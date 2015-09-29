module SpicedGracken
  class CLI
    class Who < CLI::Command
      def handle
        Display.info(ActiveServers.who)
      end
    end
  end
end
