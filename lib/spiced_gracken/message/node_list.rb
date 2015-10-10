module SpicedGracken
  module Message
    class NodeList < Base
      def message
        @message ||= Node.as_json
      end

      def handle
        respond
        return
      end

      # only need to respond if this server has node entries that the
      # sender of this message doesn't have
      def respond
        received_list = message
        we_only_have, they_only_have = Node.diff(received_list)

        if we_only_have.present?
          location = payload['sender']['location']

          node = Node.find_by_location(location)

          SpicedGracken::Http::Client.dispatch(
            node: node,
            payload: NodeListDiff.new(message: we_only_have).render
          )
        end
      end
    end
  end
end
