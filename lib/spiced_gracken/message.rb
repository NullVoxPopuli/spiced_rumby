require 'spiced_gracken/message/base'
require 'spiced_gracken/message/authorization'
require 'spiced_gracken/message/chat'
require 'spiced_gracken/message/ping'
require 'spiced_gracken/message/ping_reply'
require 'spiced_gracken/message/disconnection'
require 'spiced_gracken/message/whisper'
require 'spiced_gracken/message/relay'
require 'spiced_gracken/message/node_list'
require 'spiced_gracken/message/node_list_diff'
require 'spiced_gracken/message/node_list_hash'

module SpicedGracken
  module Message
    CHAT = 'chat'
    PING = 'ping'
    PING_REPLY = 'pingreply'
    WHISPER = 'whisper'
    RELAY = 'relay'
    DISCONNECTION = 'disconnection'
    AUTHORIZATION = 'authorization'

    NODE_LIST = 'nodelist'
    NODE_LIST_HASH = 'nodelisthash'
    NODE_LIST_DIFF = 'nodelistdiff'

    TYPES = {
      CHAT => Chat,
      WHISPER => Whisper,
      DISCONNECTION => Disconnection,
      AUTHORIZATION => Authorization,
      PING => Ping,
      PING_REPLY => PingReply,
      NODE_LIST => NodeList,
      NODE_LIST_DIFF => NodeListDiff,
      NODE_LIST_HASH => NodeListHash
    }


  end
end
