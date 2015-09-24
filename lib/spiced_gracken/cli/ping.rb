module SpicedGracken
  class CLI
    class Ping < CLI::Command
      def handle
        if lookup_field && lookup_value
          msg = Message::Ping.new

          address =
            if lookup_field == 'address'
              lookup_value
            else
              SpicedGracken.active_server_list.find(alias_name: lookup_value).try(:address)
            end

          unless address
            puts "#{lookup_value} could not be found".colorize(:red)
            return
          end

          Http::Client.send_to_and_close(
            address: address,
            payload: msg.render
          )
        else
          puts 'Usage: /ping {field} {value}  e.g.: /ping alias neurotek or /ping address 10.10.10.10:8080'.colorize(:red)
        end
      end

      def lookup_field
        sub_command
      end

      def lookup_value
        value = command_args.last
        value if value != sub_command
      end
    end
  end
end
