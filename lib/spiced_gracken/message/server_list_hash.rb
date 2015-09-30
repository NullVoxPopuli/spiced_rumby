module SpicedGracken
  module Message
    class ServerListHash < Base
      def message
        @message ||= ServerList.as_sha512
      end
    end
  end
end
