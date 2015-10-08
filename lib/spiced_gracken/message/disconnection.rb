module SpicedGracken
  module Message
    class Disconnection < Base
      def display
        address = payload['sender']['location']
        name = payload['sender']['alias']
        ActiveServers.remove(address: address)
        "#{name}@#{address} has disconnected"
      end
    end
  end
end
