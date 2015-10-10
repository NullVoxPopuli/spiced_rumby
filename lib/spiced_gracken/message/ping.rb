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

        SpicedGracken::Http::Client.send_to_and_close(
          location: location,
          payload: PingReply.new.render
        )
      end
    end
  end
end
