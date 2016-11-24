#!/usr/bin/ruby

require 'yaml'
require 'fileutils'
require 'filewatcher'
require 'colorize'
require 'optparse'

# Fonction qui permet de watch et d'envoyer les fichiers via sftp

def MonitoringSftp host



  localPath = host[:lp]
  remotePath = host[:rp]
  login = host[:username]
  host = host[:host]

  system 'clear'
  puts localPath

  # Mettre en place un tableau pour le systeme de monitoring
  FileWatcher.new(["#{localPath}"]).watch() do |filename, event|

    scp = "scp -r #{localPath} #{login}@#{host}:#{remotePath}"

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

# liste des options
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on('-a=s', '--address',"Host adress") {|h| options[:host] = h}
  opts.on('-u=s', '--username',"host Username") {|username| options[:username] = username}
  opts.on('-l=s', '--localpath',"Local path") {|lp| options[:lp] = lp}
  opts.on('-r=s', '--remotepath',"Local path") {|rp| options[:rp] = rp}

end.parse!

MonitoringSftp options

# Future class systeme reporté
class BubbleT

end
