module SpicedGracken
  class CLI
    class Config < CLI::Command
      def handle
        case sub_command
        when SET
          if is_valid_set_command?
            key, value = config_set_args

            Display.info Settings.set(key, with: value)
          else
            Display.alert('set requires a key and a value')
          end
        when DISPLAY
          Display.info Settings.display
        else
          Display.alert(
            'config command not implemented...'
          )
        end
      end

      def config_set_args
        command_args[2..3]
      end

      def is_valid_set_command?
        sub_command == SET && command_args.length == 4
      end
    end
  end
end
