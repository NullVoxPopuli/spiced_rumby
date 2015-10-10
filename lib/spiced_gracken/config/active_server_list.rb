module SpicedGracken
  module Config
    # maintains the list of servers while the client is running
    class ActiveServerList
      attr_accessor :_list

      delegate :count, to: :_list
      delegate :first, to: :_list
      delegate :last, to: :_list

      class << self
        # TODO: is there a way to delegate everything?
        delegate :save,
          :who, :all, :find, :find_all, :remove_by,
          :display_locations, :remove, :update,
          :first, :last,
          :add, :clear!, :exists?, :count, to: :instance

        def instance
          @instance ||= new
        end
      end

      def initialize
        self._list = Models::Entry.all
      end

      def clear!
        self._list ||= []
        self._list.clear
      end

      def remove(location: nil, alias_name: nil, uid: nil)
        entry = find(location: location, alias_name: alias_name, uid: uid)
        _list.delete(entry) if entry
      end

      def remove_by(field, value)
        case field
        when 'location'
          remove(location: value)
        when 'alias'
          remove(alias_name: value)
        when 'uid'
          remove(uid: value)
        end
      end

      def add(location: nil, alias_name: nil, uid: nil, public_key: nil, entry: nil)
        if e = contains?(uid: uid, location: location)
          update(e.uid, location: location, alias_name: alias_name, entry: e)
        else
          entry = Models::Entry.new(
            alias_name: alias_name,
            location: location,
            uid: uid,
            public_key: public_key
          ) unless entry

          entry.save
          _list << entry
        end
      end

      def update(uid, location: nil, alias_name: nil, entry: nil)
        entry = entry || find_by_uid(uid)
        return add(uid: uid, location: location, alias_name: alias_name) unless entry

        entry.location = location if location
        entry.alias_name = alias_name if alias_name
      end

      def find_by_uid(uid)
        contains?(uid: uid)
      end

      def exists?(uid)
        !!find_by_uid(uid)
      end

      def all
        as_array
      end

      def save
        _list.each do |entry|
          entry.save
        end
      end

      def as_array
        _list
      end

      def contains?(alias_name: nil, location: nil, uid: nil)
        _list.each do |entry|
          found = (
            (alias_name && entry.alias_name == alias_name) ||
            (location && entry.location == location) ||
            (uid && entry.uid == uid)
          )

          return entry if found
        end

        nil # not found
      end

      alias_method :find, :contains?

      def find_all(alias_name: nil, location: nil)
        _list.each_with_object([]) do |entry, entries|
          found = (
            (alias_name && entry.alias_name == alias_name) ||
            (location && entry.location == location)
          )

          entries << entry if found
        end
      end

      def display_locations
        list = _list.map do |entry|
          "#{entry.alias_name}@#{entry.location}"
        end
        list.join("\n").presence || 'no active nodes'
      end

      def who
        _list.map(&:alias_name).join(', ').presence || 'no one is online'
      end
    end
  end
end
