module SpicedGracken
  module Message
    class Base
      attr_accessor :payload, :time_recieved

      def initialize(
        message: '',
        name_of_sender: '',
        location: 'localhost')

        self.payload = {
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
        puts 'not implemented... you must implement display'.colorize(:red)
      end

      # this message should be called immediately
      # before sending to the whomever
      def render
        payload.to_json
      end
    end
  end
end
