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
      # che/ck_startup_settings

      # this will allow our listener / server to print exceptions,
      # rather than  silently fail
      Thread.abort_on_exception = true
    end

    def listen_for_commands
      process_input while client_active?
      SpicedGracken.ui.alert 'client not running'
    end

    def process_input
      msg = get_input
      create_input(msg)
    rescue SystemExit, Interrupt
      shutdown
    rescue Exception => e
      SpicedGracken.ui.error e.class.name
      SpicedGracken.ui.error e.message.colorize(:red)
      SpicedGracken.ui.error e.backtrace.join("\n").colorize(:red)
    end

    def create_input(msg)
      handler = Input.create(msg, cli: self)
      handler.handle
    rescue => e
      SpicedGracken.ui.error e.message
      SpicedGracken.ui.error e.class.name
    end

    def get_input
      gets
    end

    def client_active?
      @client.nil? || !@client.socket.closed?
    end

    def start_server
      @server = Queue.new
      # start the server thread
      Thread.new(SpicedGracken.settings) do |settings|
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
      "#{SpicedGracken.settings['ip']}:#{SpicedGracken.settings['port']}"
    end

    def check_startup_settings
      start_server if SpicedGracken.settings['autolisten']
    end

    # save config and exit
    def shutdown
      # close_server
      puts 'saving config...'
      SpicedGracken.settings.save
      SpicedGracken.active_server_list.save
      abort "\n\nGoodbye.  "
    end
  end
end
