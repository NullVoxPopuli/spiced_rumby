module SpicedGracken
  module Encryptor
    module_function

    def encrypt(message, with: key)
      e = OpenSSL::Cipher::Cipher.new 'DES-EDE3-CBC'
      e.encrypt key
      s = e.update message
      s << e.final
      s = s.unpack('H*')[0].upcase
      s
    end

    def decrypt(message, with: key)
      e = OpenSSL::Cipher::Cipher.new 'DES-EDE3-CBC'
      e.decrypt key
      s = message.to_a.pack("H*").unpack("C*").pack("c*")
      s = e.update s
      s << e.final
    end

  end
end
