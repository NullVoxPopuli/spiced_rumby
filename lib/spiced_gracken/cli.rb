require 'spiced_gracken/http/client'
require 'spiced_gracken/http/server'
require 'spiced_gracken/cli/input'
require 'spiced_gracken/cli/command'

module SpicedGracken

  # A user interface is responsible for for creating a client
  # and sending messages to that client
  class CLI
    attr_accessor :client, :settings, :server

    def initialize(settings: nil)
      @settings = settings
      display_welcome

      # this will allow our listener / server to print exceptions,
      # rather than  silently fail
      Thread.abort_on_exception = true
    end

    def listen_for_commands
      while (@client.nil?  or !@client.socket.closed?)
        begin
          msg = gets

          handler = Input.create(
            msg,
            cli: self,
            settings: @settings)

          handler.handle

        rescue SystemExit, Interrupt
          shutdown
        rescue Exception => e
          puts e.message.colorize(:red)
          puts e.backtrace.join("\n").colorize(:red)
        end
      end
    end


    def start_server
      @server = Thread.new(@settings) { |settings|
        Http::Server.new(port: settings["port"])
      }
    end

    def start_interactive_chat
      @client = Http::Client.new(address: @settings["default_host"], port: @settings["port"])
    end

    def display_welcome
      welcome = Help.welcome(texts: {configuration: @settings.as_hash})
      puts welcome
    end

    # save config and exit
    def shutdown
      puts "saving config..."
      @settings.save
      abort "\n\nGoodbye.  "
    end

  end

end
