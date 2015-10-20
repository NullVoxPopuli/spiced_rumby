module SpicedGracken
  class CLI
    class Server < CLI::Command
      ONLINE = 'online'

      def handle
        case sub_command
        when ONLINE
          Display.info Node.online.map(&:as_info) || 'no one is online'
        else
          Display.info Node.all.map(&:as_info) || 'there are no nodes'
        end
      end
    end
  end
end
