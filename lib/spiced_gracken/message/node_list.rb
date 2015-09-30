module SpicedGracken
  module Message
    class NodeList < Base
      def message
        Node.all.map(&:as_json)
      end
    end
  end
end
