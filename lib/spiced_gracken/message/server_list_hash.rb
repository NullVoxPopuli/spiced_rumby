module SpicedGracken
  module Message
    class ServerListHash < Base
      def message
        @message ||= Models::Entry.as_sha512
      end
    end
  end
end
