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

    TYPES = [
      CHAT,
      WHISPER,
      CONNECTION,
      DISCONNECTION,
      AUTHORIZATION
    ]
  end
end
