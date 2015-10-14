module SpicedGracken
  module Net
    module Listener
      module RequestProcessor

        module_function

        def process(raw)
          request = Request.new(raw)

          message = request.message
          update_sender_info(request.json)

          Display.present_message message
        end

        def update_sender_info(json)
          sender = json['sender']

          # if the sender isn't currently marked as active,
          # perform the server list exchange
          unless ActiveServers.exists?(sender['uid'])
            payload = Message::NodeListHash.new.render
            Client.send_to(
              location: sender['location'],
              payload: payload)
          end

          ActiveServers.update(
            sender['uid'],
            location: sender['location'],
            alias_name: sender['alias']
          )
        end
      end
    end
  end
end
