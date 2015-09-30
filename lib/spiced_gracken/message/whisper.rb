module SpicedGracken
  module Message
    class Whisper < Base
      attr_accessor :_to

      def initialize(
        message: nil,
        sender_name: nil,
        sender_location: nil,
        sender_uid: nil,
        time_recieved: nil,
        payload: nil,
        to: '')

        super(
          message: message,
          sender_name: sender_name,
          sender_location: sender_location,
          sender_uid: sender_uid,
          time_recieved: time_recieved,
          payload: payload)

        self._to = to
      end

      def display
        time_sent = payload['time_sent'].to_s
        time = Date.parse(time_sent)
        time_recieved = time.strftime('%e/%m/%y %H:%I:%M')

        to = _to.present? ? "->#{_to}" : ''
        "#{time_recieved} #{sender_name}#{to} > #{message}"
      end
    end
  end
end
