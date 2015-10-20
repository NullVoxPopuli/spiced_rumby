module SpicedGracken
  class CLI
    class Who < CLI::Command
      def handle
        Display.info Node.online.map(&:as_info) || 'no one is online'
      end
    end
  end
end
