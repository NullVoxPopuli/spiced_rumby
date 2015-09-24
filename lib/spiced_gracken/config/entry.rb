module SpicedGracken
  module Config
    class Entry
      attr_accessor :alias_name, :address, :uid, :public_key

      def initialize(alias_name: '', address: '', uid: '', public_key: '')
        @alias_name = alias_name
        @address = address
        @uid = uid
        @public_key = public_key
      end

      def as_json
        {
          'alias' => @alias_name,
          'address' => @address,
          'uid' => @uid,
          'publicKey' => @public_key
        }
      end

      def attributes
        {
          alias_name: @alias_name,
          address: @address,
          uid: @uid,
          public_key: @public_key
        }
      end

      def valid?
        @alias_name.present? &&
        @address.present? &&
        @uid.present? &&
        @public_key.present?
      end

      delegate :[], to: :attributes

    end
  end
end
