module SpicedGracken
  module Message
    class NodeListDiff < Base      
      def handle
        entries_we_do_not_have = message

        entries_we_do_not_have.each do |entry_as_json|
          # this will silently fail if there is a duplicate
          # or if this is an invalid entry
          Node.from_json(entry_as_json).save
        end
      end
    end
  end
end
