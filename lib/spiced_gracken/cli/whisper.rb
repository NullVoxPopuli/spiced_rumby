module SpicedGracken
  class CLI
    class Whisper < CLI::Command
      def target
        # get first arg
        command_args[0]
      end

      def message
        command_args[1..command_args.length].join(' ')
      end

      def handle
        server = SpicedGracken.active_server_list.find(alias_name: target)

        if server
          # if _cli.client and !_cli.client.socket.closed?
          m = Message::Whisper.new(
            message: message,
            name_of_sender: _settings[:alias],
            location: _cli.server_address,
            to: target
          )

          data = m.render
          m.display

          Http::Client.send_to_and_close(
            address: server['address'],
            payload: data
          )

          print "\n"
        else
          puts "server for #{target} not found or is not online".colorize(:yellow)
        end
      end
    end
  end
end
