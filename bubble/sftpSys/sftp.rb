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

  # FileWatcher.new(["#{localPath}/*"]).watch() do |filename, event|
  #
  #  scp = "scp -r #{filename} #{login}@#{host}:#{remotePath}"
  #
  #   if(event == :changed)
  #    puts filename.colorize :light_blue
  #     `#{scp}`
  #   end
  #
  #   if(event == :delete)
  #    p  uts "File deleted: " + filename
  #   end
  #
  #   if(event == :new)
  #    puts filename.blue.on_red
  #     `#{scp}`
  #   end
  #
  # end

end

def newHost

  puts "- Server name :"
  serverName = STDIN.gets.chomp

  puts "- Host adress :"
  host = STDIN.gets.chomp

  puts "- User login :"
  login = STDIN.gets.chomp

  puts "- Local path :"
  localPath = STDIN.gets.chomp

  puts "- Remote path : "
  remotePath = STDIN.gets.chomp

  data = Hash["serverName" => serverName, "host" => host, "login" => login, "localPath" => localPath, "remotePath" => remotePath]

  saveHost data

end



def testhost
  # data = "{"
  f = File.read "Hosts.json"
  data = JSON.parse f
  # data .= "}"
  puts data
end


#  flags
# args = Hash[ ARGV.join(' ').scan(/--?([^=\s]+)(?:=(\S+))?/) ]


# if(ARGV[0] == "new")
#   puts yamlHost
#   # puts newHost
# elsif(ARGV[0] == "test")
#   puts "Je suis un serveur deja établis"
#   testhost
# elsif ARGV[0] == ""
# else
#   puts "no arg"
# end


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

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  opts.on("-t", "--[no-]test", "test") do |o|
    options[:test] = o
    # getArg t
  end
  opts.on "-x", "--[no-]xx", "suivi de test" do |o|
    options[:xx] = 0
    # getArg x
  end

end.parse!

puts options
