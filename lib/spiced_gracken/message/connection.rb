module SpicedGracken
  module Message
    class Connection < Base
      def display
        address = payload['sender']['location']
        last_alias = payload['sender']['name']
        uid = payload['sender']['uid']

        ActiveServers.add(
          uid: uid,
          address: address,
          alias_name: last_alias)
      end
    end
  end
end
