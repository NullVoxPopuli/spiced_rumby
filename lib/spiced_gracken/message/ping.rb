module SpicedGracken
  module Message
    class Ping < Base

      def display
        # we'll never display our own ping to someone else...
        # or shouldn't.... or there should be different output
        # TODO: display is a bad method name
        name = payload['sender']['name']
        location = payload['sender']['location']

        respond
        "#{name}@#{location} pinged you."
      end

      def respond
        location = payload['sender']['location']

        SpicedGracken::Http::Client.send_to_and_close(
          address: location,
          payload: PingReply.new.render
        )
      end
    end
  end
end
