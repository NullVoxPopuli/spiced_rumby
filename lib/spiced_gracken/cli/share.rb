module SpicedGracken
  class CLI
    class Share < CLI::Command
      def handle
        Settings.share
      end
    end
  end
end
