module SpicedGracken
  module Config
    # maintains the list of servers while the client is running
    class ActiveServerList
      attr_accessor :_list

      delegate :count, to: :_list
      delegate :first, to: :_list
      delegate :last, to: :_list

      def initialize
        servers = SpicedGracken.server_list.as_entries
        self._list = servers
      end

      def clear!
        self._list ||= []
        self._list.clear
      end

      def remove(address: nil, alias_name: nil, uid: nil)
        entry = find(address: address, alias_name: alias_name, uid: uid)
        _list.delete(entry) if entry
      end

      def remove_by(field, value)
        case field
        when 'address'
          remove(address: value)
        when 'alias'
          remove(alias: value)
        when 'uid'
          remove(uid: value)
        end
      end

      def add(address: nil, alias_name: nil, uid: nil, public_key: nil, entry: nil)
        if e = contains?(uid: uid, address: address)
          update(e.uid, address: address, alias_name: alias_name, entry: e)
        else
          entry = Entry.new(
            alias_name: alias_name,
            address: address,
            uid: uid,
            public_key: public_key
          ) unless entry

          _list << entry
        end
      end

      def update(uid, address: nil, alias_name: nil, entry: nil)
        entry = entry || find_by_uid(uid)
        return add(uid: uid, address: address, alias_name: alias_name) unless entry

        entry.address = address if address
        entry.alias_name = alias_name if alias_name
      end

      def find_by_uid(uid)
        contains?(uid: uid)
      end

      def all
        as_array
      end

      def save
        # for now, just output everything to severs list
        SpicedGracken.server_list.servers = _list.map(&:as_json)
        SpicedGracken.server_list.save
      end

      def as_array
        _list
      end

      def contains?(alias_name: nil, address: nil, uid: nil)
        _list.each do |entry|
          found = (
            (alias_name && entry.alias_name == alias_name) ||
            (address && entry.address == address) ||
            (uid && entry.uid == uid)
          )

          return entry if found
        end

        nil # not found
      end

      alias_method :find, :contains?

      def find_all(alias_name: nil, address: nil)
        _list.each_with_object([]) do |entry, entries|
          found = (
            (alias_name && entry.alias_name == alias_name) ||
            (address && entry.address == address)
          )

          entries << entry if found
        end
      end

      def display_addresses
        list = _list.map do |entry|
          "#{entry.alias_name}@#{entry.address}"
        end
        list.join("\n").presence || 'no active nodes'
      end

      def who
        _list.map(&:alias_name).join(', ').presence || 'no one is online'
      end
    end
  end
end
