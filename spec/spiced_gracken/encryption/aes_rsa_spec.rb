require 'spec_helper'

describe SpicedGracken::Encryption::AES_RSA do
  let(:klass){ SpicedGracken::Encryption::AES_RSA }

  before(:each) do
    key_pair = OpenSSL::PKey::RSA.new(2048)
    @public_key = key_pair.public_key.export
    @private_key = key_pair.export
  end


  it 'has a message that can be decrypted' do
    message = 'message'
    encrypted = klass.encrypt(message, @public_key)
    decrypted = klass.decrypt(encrypted, @private_key)

    expect(message).to eq decrypted
  end

  it 'encrypts a really long message' do
    message = 'message' * 100
    encrypted = klass.encrypt(message, @public_key)
    decrypted = klass.decrypt(encrypted, @private_key)

    expect(message).to eq decrypted
  end

  it 'encrypts long json messages' do
    message = {
      hash1: SecureRandom.hex(1024),
      hash2: SecureRandom.hex(1024),
      hash3: SecureRandom.hex(3200)
    }.to_json

    encrypted = klass.encrypt(message, @public_key)
    decrypted = klass.decrypt(encrypted, @private_key)

    expect(message).to eq decrypted
  end


end
