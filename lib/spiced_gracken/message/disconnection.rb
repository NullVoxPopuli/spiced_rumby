module SpicedGracken
  module Message
    class Disconnection < Base
      def display
        address = payload['sender']['location']
        name = payload['sender']['name']
        ActiveServers.remove(address: address)
        "#{name}@#{address} has disconnected".colorize(:light_black)
      end
    end
  end
end
