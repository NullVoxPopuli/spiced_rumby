require 'spiced_gracken/cli/input'
require 'spiced_gracken/cli/command'
require 'spiced_gracken/cli/identity'
require 'spiced_gracken/cli/node'
require 'spiced_gracken/cli/config'
require 'spiced_gracken/cli/ping'
require 'spiced_gracken/cli/server'
require 'spiced_gracken/cli/whisper'
require 'spiced_gracken/cli/exit'
require 'spiced_gracken/cli/listen'
require 'spiced_gracken/cli/stop_listening'
require 'spiced_gracken/cli/who'
require 'spiced_gracken/cli/init'
require 'spiced_gracken/cli/share'
require 'spiced_gracken/cli/import'

module SpicedGracken
  # A user interface is responsible for for creating a client
  # and sending messages to that client
  class CLI
    attr_accessor :client, :server

    COMMAND_MAP = {
      Command::CONFIG => CLI::Config,
      Command::PING => CLI::Ping,
      Command::STOP_LISTENING => CLI::StopListening,
      Command::SERVERS => CLI::Server,
      Command::SERVER => CLI::Server,
      Command::EXIT => CLI::Exit,
      Command::QUIT => CLI::Exit,
      Command::LISTEN => CLI::Listen,
      Command::WHO => CLI::Who,
      Command::IDENTITY => CLI::Identity,
      Command::NODE => CLI::Node,
      Command::INIT => CLI::Init,
      Command::SHARE => CLI::Share,
      Command::IMPORT => CLI::Import,
      Command::EXPORT => CLI::Share
    }

    class << self

      delegate :server_location, :listen_for_commands,
        :shutdown, :start_server, :client, :server,
        :check_startup_settings, :create_input, :close_server,
        to: :instance

      def instance
        @instance ||= new
      end

    end


    def initialize
      # check_startup_settings

      # this will allow our listener / server to print exceptions,
      # rather than  silently fail
      Thread.abort_on_exception = true
    end

    def listen_for_commands
      process_input while true
    end

    def process_input
      msg = get_input
      create_input(msg)
    rescue SystemExit, Interrupt
      close_program
    rescue Exception => e
      Display.error e.class.name
      Display.error e.message.colorize(:red)
      Display.error e.backtrace.join("\n").colorize(:red)
    end

    def create_input(msg)
      handler = Input.create(msg)
      handler.handle
    rescue => e
      Display.error e.message
      Display.error e.class.name
      Display.error e.backtrace.join("\n").colorize(:red)
    end

    def get_input
      gets
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

      Thread.abort_on_exception = true
      Thin::Logging.silent = false

      Thread.new do
        begin
          SpicedGracken::Net::Listener::Server.run!(
            port: SpicedGracken::Settings['port'],
            # logger: SpicedGracken::Display,
            show_exceptions: true,
            server: :thin,
            dump_errors: true,
            threaded: true
          )
          loop while Thread.current.alive?
        rescue Exception => e
          ap e.message
          ap e.backtrace
        ensure
          ap 'Server Stopped'
        end
      end

    end

    def close_server
      puts 'shutting down server'
      if @server.present?
        server = @server.pop
        server.try(:server).try(:close)
      end
      puts 'no longer listening...'
    end

    def server_location
      Settings.location
    end

    def check_startup_settings
      start_server if Settings['autolisten']
    end

    def close_program
      exit
    end

    # save config and exit
    def shutdown
      # close_server
      Display.info 'saving config...'
      Settings.save
      Display.info 'saving servers...'
      ActiveServers.save
      Display.alert "\n\nGoodbye.  "
      exit
    end
  end
end
