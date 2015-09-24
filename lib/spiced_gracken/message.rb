require 'spiced_gracken/message/base'
require 'spiced_gracken/message/authorization'
require 'spiced_gracken/message/chat'
require 'spiced_gracken/message/connection'
require 'spiced_gracken/message/disconnection'
require 'spiced_gracken/message/whisper'

module SpicedGracken
  module Message
    CHAT = 'chat'
    WHISPER = 'whisper'
    CONNECTION = 'connection'
    DISCONNECTION = 'disconnection'
    AUTHORIZATION = 'authorization'

    SERVER_LIST = 'serverlist'
    SERVER_LIST_HASH = 'serverlisthash'
    SERVER_LIST_DIFF = 'serverlistdiff'

    TYPES = [
      CHAT,
      WHISPER,
      CONNECTION,
      DISCONNECTION,
      AUTHORIZATION,
      SERVER_LIST,
      SERVER_LIST_DIFF,
      SERVER_LIST_HASH
    ]
  end
end
