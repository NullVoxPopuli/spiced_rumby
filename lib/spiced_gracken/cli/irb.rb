module SpicedGracken
  class CLI
    class IRB < CLI::Command
      def handle
        begin
          code = command_args[1..command_args.length].join(' ')
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
