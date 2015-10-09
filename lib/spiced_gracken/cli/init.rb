module SpicedGracken
  class CLI
    class Init < CLI::Command
      def handle
        if  Settings.keys_exist?
          Display.warn 'keys exist, overwrite? (Y/N)'
          response = gets
          response = response.chomp
          if ['yes', 'y'].include?(response.downcase)
            Settings.generate_keys
          else
            Display.alert 'key generation aborted'
          end
        else
          Settings.generate_keys
        end
      end
    end
  end
end
