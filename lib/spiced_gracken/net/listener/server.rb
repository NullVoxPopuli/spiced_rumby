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
          RequestProcessor.process(raw)
        end
      end
    end
  end
end
