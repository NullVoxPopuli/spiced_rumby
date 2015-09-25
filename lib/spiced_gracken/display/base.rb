module SpicedGracken
  module Display
    class Base

      def start
        raise 'overload this method'
      end

      def add_line(line)
        raise 'overload this method'
      end

      def message_from_gracken(msg)
        raise 'overload this method'
      end

      def log(msg)
        raise 'overload this method'
      end

    end
  end
end
