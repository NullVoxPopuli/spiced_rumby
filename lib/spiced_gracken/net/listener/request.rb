module SpicedGracken
  module Net
    module Listener
      class Request
        attr_accessor :json, :message
        attr_accessor :_input

        def initialize(input)
          puts '"raw" input'
          ap input
          self._input = try_decrypt(input)
          self.json = JSON.parse(_input)
          self.message = process_json
        end

        private

        def try_decrypt(input)
          begin
            # TODO: do we want to try to decrypting anyway if decoding fails?
            decoded = Base64.decode64(input)
            puts 'decoded from base64'
            input = Cipher.decrypt(decoded, Settings[:privateKey])
          rescue => e
            Display.debug e.message
            Display.debug e.backtrace.join("\n")
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
end
