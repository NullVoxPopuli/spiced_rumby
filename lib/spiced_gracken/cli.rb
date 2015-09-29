require 'spiced_gracken/http/client'
require 'spiced_gracken/http/server'
require 'spiced_gracken/cli/input'
require 'spiced_gracken/cli/command'
require 'spiced_gracken/cli/config'
require 'spiced_gracken/cli/ping'
require 'spiced_gracken/cli/server'
require 'spiced_gracken/cli/whisper'

module SpicedGracken
  # A user interface is responsible for for creating a client
  # and sending messages to that client
  class CLI
    attr_accessor :client, :server

    def initialize
      # check_startup_settings

      # this will allow our listener / server to print exceptions,
      # rather than  silently fail
      Thread.abort_on_exception = true
    end

    def listen_for_commands
      process_input while client_active?
      Display.alert 'client not running'
    end

    def process_input
      msg = get_input
      create_input(msg)
    rescue SystemExit, Interrupt
      shutdown
    rescue Exception => e
      Display.error e.class.name
      Display.error e.message.colorize(:red)
      Display.error e.backtrace.join("\n").colorize(:red)
    end

    def create_input(msg)
      handler = Input.create(msg, cli: self)
      handler.handle
    rescue => e
      Display.error e.message
      Display.error e.class.name
    end

    def get_input
      gets
    end

    def client_active?
      @client.nil? || !@client.socket.closed?
    end

    def start_server
      unless Settings.valid?
        Display.alert("settings not fully valid\n")
        errors = Settings.errors
        errors.each do |error|
          Display.alert(" - #{error}")
        end

        if errors.present?
          Display.info('set these with /config set <field> <value>')
        end

        return
      end

      @server = Queue.new
      # start the server thread
      Thread.new(Settings) do |settings|
        @server << Http::Server.new(port: settings['port'])
      end
    end

    def close_server
      puts 'shutting down server'
      server = @server.pop
      server.try(:server).try(:close)
      puts 'no longer listening...'
    end

    def server_address
      "#{Settings['ip']}:#{Settings['port']}"
    end

    def check_startup_settings
      start_server if Settings['autolisten']
    end

    # save config and exit
    def shutdown
      # close_server
      puts 'saving config...'
      Settings.save
      ActiveServers.save
      abort "\n\nGoodbye.  "
    end
  end
end
