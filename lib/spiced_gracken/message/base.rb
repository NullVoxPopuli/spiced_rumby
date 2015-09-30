module SpicedGracken
  module Message
    class Base
      attr_accessor :payload, :time_recieved,
        :message, :sender_name, :sender_location, :sender_uid

      # @param [String] message
      # @param [String] name_of_sender
      # @param [String] location the location of the sender
      # @param [Hash] payload optionally overrides the default payload
      def initialize(
        message: '',
        sender_name: Settings['alias'],
        sender_location: Settings.location,
        sender_uid: Settings['uid'],
        time_recieved: nil,
        payload: nil)

        @payload = payload.presence

        self.message = message.presence || @payload.try(:[], 'message')
        self.sender_name = sender_name.presence || @payload.try(:[], 'sender').try(:[], 'name')
        self.sender_location = sender_name.presence || @payload.try(:[], 'sender').try(:[], 'location')
        self.sender_uid = sender_uid.presence || @payload.try(:[], 'sender').try(:[], 'uid')
        self.time_recieved = time_recieved.presence || Time.now

      end

      def payload
        @payload ||= {
          'type' => type,
          'message' => message,
          'client' => client,
          'client_version' => client_version,
          'time_sent' => time_recieved || Time.now.to_s,
          'sender' => {
            'name' => sender_name,
            'location' => sender_location,
            'uid' => sender_uid
          }
        }
      end

      def type
        @type ||= TYPES.invert[self.class]
      end

      def client
        SpicedGracken::NAME
      end

      def client_version
        SpicedGracken::VERSION
      end

      def display
        message
      end

      # this message should be called immediately
      # before sending to the whomever
      def render
        payload.to_json
      end
    end
  end
end
