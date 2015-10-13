module SpicedGracken
  module Message
    class Relay < Base
      def initialize(
        message: nil,
        sender_name: nil,
        sender_location: nil,
        sender_uid: nil,
        time_recieved: nil,
        payload: nil,
        destination: '',
        hops: [])

        # package the original message
        message = {
          message: message,
          destination: destination,
          hops: hops
        }

        super(
          message: message,
          sender_name: sender_name,
          sender_location: sender_location,
          sender_uid: sender_uid,
          time_recieved: time_recieved,
          payload: payload)
      end
    end
  end
end
