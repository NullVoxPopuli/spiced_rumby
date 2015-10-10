module SpicedGracken
  module Encryption
    # This should normally be for testing
    #
    # It just retuns the message that is asked to be encrypted
    module Passthrough
      module_function
      def encrypt(msg, *args)
        msg
      end

      def decrypt(msg, *args)
        msg
      end
    end
  end
end
