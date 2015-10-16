module SpicedGracken
  class CLI
    class Init < CLI::Command
      def handle
        if Settings.uid_exists?
          if confirm? 'uid exists, are you sure you want a new identity?'
            Settings.generate_uid
          else
            Display.alert 'uid generation aborted'
          end
        else
          Settings.generate_uid
        end

        if Settings.keys_exist?
          if confirm? 'keys exist, overwrite?'
            Settings.generate_keys
          else
            Display.alert 'key generation aborted'
          end
        else
          Settings.generate_keys
        end
      end

      def confirm?(msg)
        Display.warning(msg + ' (Y/N)')
        response = gets
        response = response.chomp
        ['yes', 'y'].include?(response.downcase)
      end
    end
  end
end
