module SpicedGracken
  module Message
    class Connection < Base
      def display
        location = payload['sender']['location']
        last_alias = payload['sender']['alias']
        uid = payload['sender']['uid']

        ActiveServers.add(
          uid: uid,
          location: location,
          alias_name: last_alias)
      end
    end
  end
end
