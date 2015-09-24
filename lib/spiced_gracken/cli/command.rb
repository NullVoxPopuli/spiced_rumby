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
      STOP_LISTENING = 'stoplistening'
      CONNECT = 'connect'
      CHAT = 'chat'
      ADD = 'add'
      REMOVE = 'remove'
      RM = 'rm'
      SERVERS = 'servers'
      SERVER = 'server'
      WHO = 'who'

      def handle
        # these could even be split up in to classes if they needed to be
        case command
        when WHO
          puts SpicedGracken.active_server_list.who
        when STOP_LISTENING
          _cli.close_server
        when SERVERS, SERVER
          case config_command
          when ADD
            if is_valid_add_command?
              address = command_args[2]

              SpicedGracken.active_server_list.add(
                address: address
              )
            else
              puts 'add requires an address and port'
            end
          when WHO
            puts SpicedGracken.active_server_list.who
          when REMOVE, RM
            if is_valid_remove_command?
              field, value = config_set_args

              SpicedGracken.active_server_list.remove_by(field, value)
            else
              puts 'requires address or alias. ex: /server rm alias evan'
            end
          else
            if command_args.length > 0
              SpicedGracken.active_server_list.display_addresses
            else
              puts 'server command not implemented...'.colorize(:red)
            end
          end
        when CONFIG
          case config_command
          when SET
            if is_valid_set_command?
              key, value = config_set_args

              _settings.set(key, with: value)
            else
              puts 'set requires a key and a value'.colorize(:red)
            end
          when DISPLAY
            _settings.display
          else
            puts 'config command not implemented....'.colorize(:red)
          end
        when EXIT, QUIT
          _cli.shutdown
        when LISTEN
          _cli.start_server
        when CONNECT, CHAT
          _cli.start_interactive_chat
        else
          puts 'not implemented...'.colorize(:red)
        end
      end

      private

      def command_string
        _input[1, _input.length]
      end

      def command_args
        command_string.split(' ')
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

      def is_valid_add_command?
        config_command == ADD && command_args.length == 3
      end

      def is_valid_remove_command?
        (config_command == REMOVE || config_command == RM) && command_args.length == 4
      end
    end
  end
end
