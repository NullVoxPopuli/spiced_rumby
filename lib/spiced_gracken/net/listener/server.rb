require 'sinatra/base'

module SpicedGracken
  module Net
    module Listener
      class Server < Sinatra::Base
        configure :development do
          # enable :logging
          set :show_exceptions, :after_handler
          set :threaded, true
        end
        # TODO: do we want to return an error if
        # we can't decrypt?

        get '/' do
          process_request
          ok
        end

        post '/' do
          process_request
          ok
        end

        def process_request
          raw = params[:message]
          RequestProcessor.process(raw)
        end

        def ok
          status 200
          body 'OK'
        end
      end
    end
  end
end
