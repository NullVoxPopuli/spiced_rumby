module SpicedGracken
  class CLI
    class Exit < CLI::Command
      def handle
        CLI.shutdown
      end
    end
  end
end
