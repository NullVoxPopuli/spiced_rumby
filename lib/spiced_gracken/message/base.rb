module SpicedGracken
  module Message
    class Base
      attr_accessor :payload, :time_recieved

      # @param [String] message
      # @param [String] name_of_sender
      # @param [String] location the location of the sender
      # @param [Hash] payload optionally overrides the default payload
      def initialize(
        message: '',
        name_of_sender: '',
        location: 'localhost',
        payload: nil)

        self.payload = payload || {
          'type' => WHISPER,
          'message' => message,
          'client' => SpicedGracken::NAME,
          'client_version' => SpicedGracken::VERSION,
          'time_sent' => Time.now.to_s, # not yet sent
          'sender' => {
            'name' => name_of_sender,
            'location' => location
          }
        }
      end

      def display
        SpicedGracken.ui.alert 'not implemented... you must implement display'
      end

      # this message should be called immediately
      # before sending to the whomever
      def render
        payload.to_json
      end
    end
  end
end
