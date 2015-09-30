module SpicedGracken
  module Message
    class NodeListHash < Base
      def message
        @message ||= Node.as_sha512
      end

      # node list hash is received
      # @return [NilClass] no output for this message type
      def handle
        respond
        return
      end

      def respond
        if message != Node.as_sha512
          location = payload['sender']['location']

          SpicedGracken::Http::Client.send_to_and_close(
            address: location,
            payload: NodeList.new.render
          )
        end
      end
    end
  end
end
