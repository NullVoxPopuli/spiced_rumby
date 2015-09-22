require 'spiced_gracken/http/client'
require 'spiced_gracken/http/server'

module SpicedGracken

  # A user interface is responsible for for creating a client
  # and sending messages to that client
  class CommandLineInterface
    attr_accessor :client, :settings, :server

    def initialize(settings: nil)
      @settings = settings
      display_welcome

      # this will allow our listener / server to print exceptions,
      # rather than  silently fail
      Thread.abort_on_exception = true

      listen_for_commands
    end

    def listen_for_commands
      while (@client.nil?  or !@client.socket.closed?)
        begin
          msg = gets
          handle_input(msg)
        rescue SystemExit, Interrupt
          shutdown
        rescue Exception => e
          puts e.message.colorize(:red)
          puts e.backtrace.join("\n").colorize(:red)
        end
      end
    end

    def handle_input(input)
      input.chomp!
      is_command = ( input[0,1] == "/" )

      if is_command
        command_string = input[1, input.length]
        c_args = command_string.split(" ")

        case c_args[0]
        when "config", "settings"
          case c_args[1]
          when "set"
            if c_args.length == 4
              key = c_args[2]
              value = c_args[3]

              @settings.set(key, with: value)
            else
              ap "set requires a key and a value"
            end
          when "display"
            @settings.display
          else
            ap "config commend not implemented...."
          end
        when "exit", "quit"; shutdown
        when "listen"; start_server
        when "connect", "chat"; start_interactive_chat
        else
          ap "not implemented..."
        end
      elsif @client and !@client.socket.closed?
        m = Message::Text.new(
          message: input,
          name_of_sender: @settings[:alias]
        )
        m.display
        data = m.render

        @client.send(message: data)
        print "\n"
      else
        puts "start listening, and then start a chat".colorize(:yellow)
      end
    end

    private

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

    def start_server
      @server = Thread.new(@settings) { |settings|
        Http::Server.new(port: settings["port"])
      }
    end

    def start_interactive_chat
      @client = Http::Client.new(address: @settings["default_host"], port: @settings["port"])
    end
  end

end
