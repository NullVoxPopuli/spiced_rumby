module SpicedGracken
  class CLI
    class PingAll < CLI::Command
      def handle
        Node.all.each do |n|
          Net::Client.send(node: n, message: Message::Ping.new)
        end
      end
    end
  end
end
