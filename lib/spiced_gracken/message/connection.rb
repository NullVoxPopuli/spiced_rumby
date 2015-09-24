module SpicedGracken
  module Message
    class Connection < Base
      def display
        address = @payload['sender']['location']
        last_alias = @payload['sender']['name']
        SpicedGracken.active_server_list.add(
          address: address,
          alias_name: last_alias)
      end
    end
  end
end
