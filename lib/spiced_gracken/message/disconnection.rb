module SpicedGracken
  module Message
    class Disconnection < Base
      def display
        location = payload['sender']['location']
        name = payload['sender']['alias']
        node = Node.find(location: location).first
        node.update(online: false) if node
        "#{name}@#{location} has disconnected"
      end
    end
  end
end
