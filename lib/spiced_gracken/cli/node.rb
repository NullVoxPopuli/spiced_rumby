module SpicedGracken
  class CLI
    class Node < CLI::Command
      def handle
        begin
          code = 'SpicedGracken::Models::Entry.' + command_args[1..command_args.length].join(' ')
          ap eval(code)
          ''
        rescue => e
          ap e.message
          ap e.backtrace
        end
      end
    end
  end
end
