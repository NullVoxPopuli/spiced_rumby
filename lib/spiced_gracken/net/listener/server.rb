require 'sinatra/base'

module SpicedGracken
  module Net
    module Listener
      class Server < Sinatra::Base
        configure :development do
          enable :logging
          enable :lock
          set :show_exceptions, :after_handler
        end
        # TODO: do we want to return an error if
        # we can't decrypt?

        get '/' do
          process_request
          # status 200 # server accepts all messages
        end

        post '/' do
          process_request
          # status 200 # server accepts all messages
        end

        def process_request
          raw = params[:message]
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
