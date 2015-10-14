module SpicedGracken
  module Net
    # TODO: Write abstraction of destination node and message
    # TODO: maybe this can have the logic to determine when to relay?
    class Request
      attr_accessor :_node, :_message, :_payload

      def initialize(node, message)
        self._node = node
        self._message = message
      end

      def payload
        unless _payload
          self._payload = _message.render

          if _node.public_key
            self._payload = Cipher.encrypt(_payload, _node.public_key)
          end

          self._payload = Base64.encode64(_payload)
        end

        _payload
      end

    end
  end
end
