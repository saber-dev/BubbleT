#!/usr/bin/ruby

require 'yaml'
require 'fileutils'
require 'filewatcher'
require 'json'
require 'colorize'
require 'optparse'

def jsonHost data

  puts data

  puts "IP :: #{data['host']} || Name :: #{data['login']} || Local :: #{data['localPath']} || Remote :: #{data['remotePath']} ".delete("\n")

  puts "right ?"
  confirm = STDIN.gets.chomp

  if confirm.eql? "yes".to_s
    puts "Confirm"

    hostFile = File.new "#{data['serverName']}.json", "w+"
    fileContent = "{\"host\": \"#{data['host']}\", \"login\": \"#{data['login']}\", \"local\": \"#{data['localPath']}\", \"remote\": \"#{data['remotePath']}\"}"
    # hostFile.puts "toto"
    hostFile.close

    # file = "Hosts/#{data['serverName']}.json"
    #
    if File.file?file
      puts file
      file = File.new file, "a"
      file.puts(fileContent)
      file.close
    end

  end

end

def yamlHost

  puts "yaml"
  # puts data
  # puts "IP :: #{data['host']} || Name :: #{data['login']} || Local :: #{data['localPath']} || Remote :: #{data['remotePath']} ".delete("\n")

# Load the file.
  yaml = YAML.load_stream(File.open('Hosts/Hosts.yaml'))

  yaml.documents[0]['new_key'] = 'new_value'

  File.open('Hosts/Hosts.yaml', 'w') do |file|
    file.write(yaml.emit)
  end


end

def MonitoringSftp host

  puts host

  localPath = host[:lp]
  remotePath = host[:rp]
  login = host[:username]
  host = host[:host]

  FileWatcher.new(["#{localPath}/*"]).watch() do |filename, event|

   scp = "scp -r #{filename} #{login}@#{host}:#{remotePath}"

    if(event == :changed)
     puts filename.colorize :light_blue
      `#{scp}`
    end

    if(event == :delete)
     p  uts "File deleted: " + filename
    end

    if(event == :new)
     puts filename.blue.on_red
      `#{scp}`
    end

  end

end


# system("clear")

def testOne
  puts "je suis un test"
end

def testTwo
  puts "je susis un second test"
end

def getArg arg
  puts arg
end
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on('-a=s', '--address',"Host adress") {|h| options[:host] = h}
  opts.on('-u=s', '--username',"host Username") {|username| options[:username] = username}
  opts.on('-l=s', '--localpath',"Local path") {|lp| options[:lp] = lp}
  opts.on('-r=s', '--remotepath',"Local path") {|rp| options[:rp] = rp}


end.parse!

# options = OptparseExample.parse(ARGV)
# p options.parse ARGV

# p options


MonitoringSftp options




#
# begin
#   ARGV << "-h" if ARGV.size != 2
#   option_parser.parse!(ARGV)
# rescue OptionParser::ParseError
#   $stderr.print "Error: " + $! + "\n"
#   exit
# end
