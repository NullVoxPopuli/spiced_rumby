require 'spec_helper'

describe SpicedGracken::Encryption::AES_RSA do
  let(:klass){ SpicedGracken::Encryption::AES_RSA }

  before(:each) do
    key_pair = OpenSSL::PKey::RSA.new(2048)
    @public_key = key_pair.public_key.export
    @private_key = key_pair.export
  end


  it 'has a message can be decrypted' do
    message = 'message'
    encrypted = klass.encrypt(message, @public_key)
    decrypted = klass.decrypt(encrypted, @private_key)

    expect(message).to eq decrypted
  end

end
