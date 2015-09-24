module SpicedGracken
  class CLI
    class Server < CLI::Command

      def handle
        case sub_command
        when ADD
          if is_valid_add_command?
            address = command_args[2]

            SpicedGracken.active_server_list.add(
              address: address
            )
          else
            puts 'add requires an address and port'
          end
        when REMOVE, RM
          if is_valid_remove_command?
            field, value = sub_command_args

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
      end

      def is_valid_add_command?
        sub_command == ADD && command_args.length == 3
      end

      def is_valid_remove_command?
        (sub_command == REMOVE || sub_command == RM) && command_args.length == 4
      end
    end
  end
end
