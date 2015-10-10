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

          node = Node.find_by_location(location)

          SpicedGracken::Http::Client.dispatch(
            node: node,
            payload: NodeList.new(message: Node.as_json).render
          )
        end
      end
    end
  end
end
