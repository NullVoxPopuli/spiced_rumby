require 'spiced_gracken/message/base'
require 'spiced_gracken/message/authorization'
require 'spiced_gracken/message/chat'
require 'spiced_gracken/message/ping'
require 'spiced_gracken/message/ping_reply'
require 'spiced_gracken/message/connection'
require 'spiced_gracken/message/disconnection'
require 'spiced_gracken/message/whisper'
require 'spiced_gracken/message/server_list'
require 'spiced_gracken/message/server_list_diff'
require 'spiced_gracken/message/server_list_hash'

module SpicedGracken
  module Message
    CHAT = 'chat'
    PING = 'ping'
    PING_REPLY = 'pingreply'
    WHISPER = 'whisper'
    CONNECTION = 'connection'
    DISCONNECTION = 'disconnection'
    AUTHORIZATION = 'authorization'

    SERVER_LIST = 'serverlist'
    SERVER_LIST_HASH = 'serverlisthash'
    SERVER_LIST_DIFF = 'serverlistdiff'

    TYPES = {
      CHAT => Chat,
      WHISPER => Whisper,
      CONNECTION => Connection,
      DISCONNECTION => Disconnection,
      AUTHORIZATION => Authorization,
      PING => Ping,
      PING_REPLY => PingReply,
      SERVER_LIST => ServerList,
      SERVER_LIST_DIFF => ServerListDiff,
      SERVER_LIST_HASH => ServerListHash
    }


  end
end
