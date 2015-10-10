module SpicedGracken
  module Message
    class Disconnection < Base
      def display
        location = payload['sender']['location']
        name = payload['sender']['alias']
        ActiveServers.remove(location: location)
        "#{name}@#{location} has disconnected"
      end
    end
  end
end
