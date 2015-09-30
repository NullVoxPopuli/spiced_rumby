module SpicedGracken
  class CLI
    class Node < CLI::Command
      def handle
        code = 'SpicedGracken::Models::Entry.' + command_args[1..command_args.length].join(' ')
        ap eval(code)
        ''
      end
    end
  end
end
