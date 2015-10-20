module SpicedGracken
  class CLI
    class Ping < CLI::Command
      def handle
        if command_valid?
          msg = Message::Ping.new

          field, value = parse_ping_command

          node =
            if field == 'location'
              Node.find(location: lookup_value).first
            else
              Node.find(alias_name: lookup_value).first
            end

          location = node.try(:location)

          unless location
            return Display.alert "#{lookup_value} could not be found"
          end

          Net::Client.send(
            node: node,
            message: msg
          )
        else
          Display.alert usage
        end
      end

      def usage
        'Usage: /ping {field} {value}  e.g.: /ping alias neurotek or /ping location 10.10.10.10:8080'
      end

      def lookup_field
        sub_command
      end

      def lookup_value
        value = command_args.last
        value if value != sub_command
      end

      def command_valid?
        parse_ping_command.compact.length == 2
      end

      def parse_ping_command
        @parsed_args ||=
          if lookup_field == 'location' || lookup_field == 'alias'
            [lookup_field, lookup_value]
          elsif lookup_field =~ /(?:[0-9]{1,3}\.){3}[0-9]{1,3}/
            ['location', lookup_field]
          else
            ['alias', lookup_field]
          end
      end
    end
  end
end
