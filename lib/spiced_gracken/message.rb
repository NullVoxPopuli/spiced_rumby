require 'spiced_gracken/message/authorize'
require 'spiced_gracken/message/chat'
require 'spiced_gracken/message/connect'
require 'spiced_gracken/message/disconnect'
require 'spiced_gracken/message/whisper'

module SpicedGracken
  module Message
    CHAT = 'chat'
    WHISPER = 'whisper'
    CONNECT = 'connect'
    DISCONNECT = 'disconnect'
    AUTHORIZE = 'authorize'

    TYPES = [
      CHAT,
      WHISPER,
      CONNECT,
      DISCONNECT,
      AUTHORIZE
    ]
  end
end
