require 'sinatra/base'

module SpicedGracken
  module Net
    module Listener
      class Server < Sinatra::Base
        configure :development do
          # only shows resulting status
          disable :logging
          # enable :logging
          set :bind, '0.0.0.0' #['10.10.2.29','127.0.0.1', 'localhost']
          # set :show_exceptions, :after_handler
          set :threaded, true
        end
        # TODO: do we want to return an error if
        # we can't decrypt?

        get '/' do
          process_request
        end

        post '/' do
          process_request
        end

        def process_request
          Display.debug request.env

          begin
            # form params should override
            # raw body
            raw =
              if msg = params[:message]
                msg
              else
                request_body = request.body.read
                json_body = JSON.parse(request_body)
                json_body['message']
              end

            # decode, etc
            RequestProcessor.process(raw)

            # hopefully everything went ok
            ok
          rescue => e
            Display.error e.message
            Display.error e.backtrace.join("\n")
            body e.message
            status 500
          end
        end

        def ok
          status 200
          body 'OK'
        end
      end
    end
  end
end
