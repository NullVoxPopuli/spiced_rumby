module SpicedGracken
  module Message
    #
    # NOTE:
    #  #display: shows the message
    #            should be used locally, before *sending* a message
    #  #handle: processing logic for the message
    #           should be used when receiving a message, and there
    #           needs to be a response right away
    #  #respond: where the actual logic for the response goes
    class Base
      attr_accessor :payload, :time_recieved,
        :message, :sender_name, :sender_location, :sender_uid

      # @param [String] message
      # @param [String] name_of_sender
      # @param [String] location the location of the sender
      # @param [Hash] payload optionally overrides the default payload
      def initialize(
        message: '',
        sender_name: '',
        sender_location: '',
        sender_uid: '',
        time_recieved: nil,
        payload: nil)

        @payload = payload.presence

        # TODO: find a more elegant way to represent this
        self.message = message.presence || @payload.try(:[], 'message')
        self.sender_name = sender_name.presence || @payload.try(:[], 'sender').try(:[], 'name') || Settings['alias']
        self.sender_location = sender_location.presence || @payload.try(:[], 'sender').try(:[], 'location') || Settings.location
        self.sender_uid = sender_uid.presence || @payload.try(:[], 'sender').try(:[], 'uid') || Settings['uid']
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

      # shows the message
      # should be used locally, before *sending* a message
      def display
        message
      end

      # processing logic for the message
      # should be used when receiving a message, and there
      # needs to be a response right away.
      # this may call display, if the response is always to be displayed
      def handle
        display
      end

      # Most message types aren't going to need to have an
      # immediate response.
      # 
      def respond
        return
      end

      # this message should be called immediately
      # before sending to the whomever
      def render
        payload.to_json
      end
    end
  end
end
