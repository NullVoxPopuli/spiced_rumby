module SpicedGracken
  module Display
    class Base

      def start
        fail 'overload this method'
      end

      def add_line(_line)
        fail 'overload this method'
      end

      def whisper(_line)
        fail 'overload this method'
      end

      def log(_msg)
        fail 'overload this method'
      end
    end
  end
end
