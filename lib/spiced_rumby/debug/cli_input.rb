module SpicedRumby
    module Debug
    class CLIInput < MeshChat::CLI::Base
      class << self
        def autocompletes
          commands = MeshChat::CLI::COMMAND_MAP.map{ |k, v| "/#{k}" }
          aliases = MeshChat::Node.all.map{ |n| "#{n.alias_name}" }
          commands + aliases
        end
      end

      # called every time meshchat wants a line of text from the user
      def get_input
        # update auto completion
        completion = proc{ |s| self.class.autocompletes.grep(/^#{Regexp.escape(s)}/) }
        Readline.completion_proc = completion

        Readline.readline('> ', true)
      end
    end
  end
end
