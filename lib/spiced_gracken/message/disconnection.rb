module SpicedGracken
  module Message
    class Disconnection < Base
      def display
        address = payload['sender']['location']
        name = payload['sender']['name']
        SpicedGracken.active_server_list.remove(
          address: address)
        puts s = "#{name}@#{address} has disconnected".colorize(:light_black)
        s
      end
    end
  end
end
