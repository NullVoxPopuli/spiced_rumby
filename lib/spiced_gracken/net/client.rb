module SpicedGracken
  module Net
    module Client
      module_function

      # @note Either the location, node, or uid should be present
      #
      # @param [String] location (Optional) location of target
      # @param [String] uid (Optional) uid of target
      # @param [Node] node (Optional) target
      # @param [Message] message (Required) what to send to the target
      def send(location: nil, uid: nil, node: nil, message: nil)
        # verify node is valid
        node = self.node_for(location: location, uid: uid, node: node)

        Thread.new(node, message) do |node, message|
          request = SpicedGracken::Net::Request.new(node, message)
          payload = { message: request.payload }
          begin
            Curl::Easy.http_post(node.location, payload.to_json) do |c|
              c.headers['Accept'] = 'application/json'
              c.headers['Content-Type'] = 'application/json'
              if SpicedGracken::Settings.debug?
                puts message.render
                c.verbose = true
                c.on_debug do |type, data|
                  puts data
                end
              end
            end
          rescue => e
            Display.alert("Issue connectiong to #{node.alias_name}@#{node.location}")
            Display.alert(e.message)
          end
        end
      end

      # private

      # @return [Node]
      def node_for(location: nil, uid: nil, node: nil)
        unless node
          node = Models::Entry.find_by_location(location) if location
          node = Models::Entry.find_by_uid(uid) if uid && !node
        end

        # TODO: also check for public key?
        # without the public key, the message is sent in cleartext. :-\
        if !(node && node.location)
          Display.alert "Node not found, or does not have a location"
          return
        end

        node
      end
    end
  end
end
