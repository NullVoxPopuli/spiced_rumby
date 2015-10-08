module SpicedGracken
  module Message
    class Chat < Base
      include Encryptor

      def display
        time_recieved = self.time_recieved.strftime('%e/%m/%y %H:%I:%M')
        name = payload['sender']['alias']
        message = payload['message']

        "#{time_recieved} #{name} > #{message}"
      end
    end
  end
end
