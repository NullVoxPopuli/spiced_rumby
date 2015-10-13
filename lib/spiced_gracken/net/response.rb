module SpicedGracken
  module Net
    class Response
      attr_accessor :json, :message
      attr_accessor :_input

      def initialize(input)
        self._input = try_decrypt(input)
        self.json = JSON.parse(_input)
        self.message = process_json
      end

      private

      def try_decrypt(input)
        begin
          Display.debug input.encoding
          input = input.encode!(Encoding::UTF_8)
          Display.debug input.encoding
          Display.debug Settings[:privateKey]
          input = Cipher.decrypt(input, Settings[:privateKey])
        rescue => e
          Display.warning e.message
          Display.info 'It\'s possible that this message was sent in cleartext, or was encrypted with the wrong public key'
        end

        Display.debug 'server received message:'
        Display.debug input

        input
      end

      def process_json
        type = json['type']
        klass = Message::TYPES[type]

        unless klass
          Display.alert 'message recieved and not recognized...'
          return
        end

        klass.new(payload: json)
      end
    end
  end
end
