module SpicedGracken
  module Encryption
    # Using AES266-CBC with RSA
    #
    # Docs on AES
    # http://ruby-doc.org/stdlib-2.0.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html
    module AES_RSA
      module_function

      # Use Cipher Block Chaining
      # https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Cipher_Block_Chaining_.28CBC.29
      AES_MODE = :CBC

      # 1. Generate random AES key to encrypt message
      # 2. Use Public Key to encrypt AES Key
      # 3. Prepend encrypted AES key to the encrypted message
      #
      # Output message format will look like the following:
      #
      #  {RSA Encrypted AES Key}{RSA Encrypted IV}{AES Encrypted Message}
      def encrypt(msg, public_key)
        # 1
        cipher = OpenSSL::Cipher::AES256.new(AES_MODE)
        cipher.encrypt
        aes_key = cipher.random_key
        aes_iv = cipher.random_iv
        aes_encrypted_message = cipher.update(msg)
        # pad, because of how CBC works
        padding = cipher.final
        # length = 16 - (aes_encrypted_message.length % 16)
        # length = 0 if length == 16
        # padding = ' ' * length
        # ap aes_encrypted_message.length
        # ap aes_encrypted_message.length % 16
        # ap length
        encrypted = aes_encrypted_message + padding

        # 2
        rsa_encryptor = OpenSSL::PKey::RSA.new public_key
        rsa_encrypted_aes_key = rsa_encryptor.public_encrypt(aes_key)
        rsa_encrypted_aes_iv = rsa_encryptor.public_encrypt(aes_iv)

        # 3
        rsa_encrypted_aes_key + rsa_encrypted_aes_iv + encrypted
      end

      # 1. Split the string in to the AES key and the encrypted message
      # 2. Decrypt the AES key using the private key
      # 3. Decrypt the message using the AES key
      def decrypt(msg, private_key)
        # 1
        rsa_encrypted_aes_key = msg[0..255] # 256 bits
        rsa_encrypted_aes_iv = msg[256..511] # next 256 bits
        aes_encrypted_message = msg[512..msg.length]

        # 2
        rsa_decryptor = OpenSSL::PKey::RSA.new private_key
        aes_key = rsa_decryptor.private_decrypt rsa_encrypted_aes_key
        aes_iv = rsa_decryptor.private_decrypt rsa_encrypted_aes_iv

        # 3
        decipher = OpenSSL::Cipher::AES256.new(AES_MODE)
        decipher.decrypt
        decipher.key = aes_key
        decipher.iv = aes_iv

        decipher.update(aes_encrypted_message) + decipher.final
      end
    end
  end
end
