module SpicedGracken
  module Message
    class Ping < Base

      def display
        # we'll never display our own ping to someone else...
        # or shouldn't.... or there should be different output
        # TODO: display is a bad method name
        name = payload['sender']['alias']
        location = payload['sender']['location']

        "#{name}@#{location} pinged you."
      end

      def handle
        respond
        display
      end

      def respond
        location = payload['sender']['location']

        node = Node.find_by_location(location)

        SpicedGracken::Net::Client.send(
          node: node,
          message: PingReply.new
        )
      end
    end
  end
end
