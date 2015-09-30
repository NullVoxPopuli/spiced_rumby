module SpicedGracken
  module Message
    class ServerList < Base
      def message
        ::ServerList._hash
      end
    end
  end
end
