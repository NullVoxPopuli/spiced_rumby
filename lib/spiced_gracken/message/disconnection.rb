module SpicedGracken
  module Message
    class Disconnection < Base

      def display
        address = payload['sender']['location']
        name = payload['sender']['name']
        SpicedGracken.server_list.inactive!(address)
        puts "#{name} (#{address}) has disconnected".colorize(:light_black)
      end

    end
  end
end
