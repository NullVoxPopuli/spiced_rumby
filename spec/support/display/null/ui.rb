module MeshChatStub
  module Display
    # for testing!
    module Null
      class UI < MeshChat::Display::Base
        def start(*args); args.join; end
        def add_line(*args); args.join; end
        def info(*args); args.join; end
        def alert(*args); args.join; end
        def success(*args); args.join; end
        def chat(*args); args.join; end
        def whisper(*args); args.join; end
        def warning(*args); args.join; end
        def log(*args); args.join; end
        def error(*args); args.join; end
      end
    end
  end
end
