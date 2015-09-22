module SpicedGracken
  class CLI
    class Command < CLI::Input

      attr_accessor :_input

      # Commands
      SET = 'set'
      CONFIG = 'config'
      DISPLAY = 'display'
      EXIT = 'exit'
      QUIT = 'quit'
      LISTEN = 'listen'
      CONNECT = 'connect'
      CHAT = 'chat'


      def handle
        # these could even be split up in to classes if they needed to be
        case command
        when CONFIG
          case config_command
          when SET
            if is_valid_set_command?
              key, value = config_set_args

              _settings.set(key, with: value)
            else
              puts "set requires a key and a value".colorize(:red)
            end
          when DISPLAY
            _settings.display
          else
            puts "config command not implemented....".colorize(:red)
          end
        when EXIT, QUIT
          _cli.shutdown
        when LISTEN
          _cli.start_server
        when CONNECT, CHAT
          _cli.start_interactive_chat
        else
          puts "not implemented...".colorize(:red)
        end
      end

      private

      def command_string
        _input[1, _input.length]
      end

      def command_args
        command_string.split(" ")
      end

      def command
        command_args.first
      end

      def config_command
        command_args[1]
      end

      def config_set_args
        command_args[2..3]
      end

      def is_valid_set_command?
        config_command == SET && command_args.length == 4
      end

    end
  end
end
