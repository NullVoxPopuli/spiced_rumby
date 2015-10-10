module SpicedGracken
  class CLI
    class Server < CLI::Command
      def handle
        case sub_command
        when ADD
          if is_valid_add_command?
            info = command_args[2]
            alias_name, info = info.split('@')
            location, uid = info.split('#')


            ActiveServers.add(
              location: location,
              alias_name: alias_name,
              uid: uid
            )
          else
            s = 'add requires alias@ip:port#uid'
            Display.alert(s)
          end
        when REMOVE, RM
          if is_valid_remove_command?
            field, value = sub_command_args

            ActiveServers.remove_by(field, value)
          else
            s = 'requires location or alias. ex: /server rm alias evan'
            Display.alert(s)
          end
        else
          if command_args.length > 0
            s = ActiveServers.display_locations
            Display.info(s)
          else
            s = 'server command not implemented...'
            Display.alert(s)
          end
        end
      end

      def is_valid_add_command?
        sub_command == ADD && command_args.length == 3 &&
        command_args[2].include?('@') && command_args[2].include?(':') &&
        command_args[2].include?('#')
      end

      def is_valid_remove_command?
        (sub_command == REMOVE || sub_command == RM) && command_args.length == 4
      end
    end
  end
end
