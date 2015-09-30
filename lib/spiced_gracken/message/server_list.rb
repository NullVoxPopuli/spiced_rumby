module SpicedGracken
  module Message
    class ServerList < Base
      def message
        SpicedGracken::Models::Entry.all.map(&:as_json)
      end
    end
  end
end
