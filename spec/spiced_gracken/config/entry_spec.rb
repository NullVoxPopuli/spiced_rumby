require 'spec_helper'

describe SpicedGracken::Models::Entry do
  let(:klass) { SpicedGracken::Models::Entry }

  before(:each) do
    mock_settings_objects
  end

  describe '#as_json' do
    it 'converts to a hash / json' do
      m = klass.new(
        alias_name: 'alias',
        address: '1.1.1.1:8080',
        uid: '1',
        public_key: '123')


      expected = {
        'alias' => 'alias',
        'address' => '1.1.1.1:8080',
        'uid' => '1',
        'publicKey' => '123'
      }

      expect(m.as_json).to eq expected
    end
  end

  describe '#valid?' do

    it 'is false without an alias' do
      m = klass.new(alias_name: '')
      expect(m).to_not be_valid
    end

    it 'is false without an address' do
      m = klass.new(address: '')
      expect(m).to_not be_valid
    end

    it 'is false without a uid' do
      m = klass.new(uid: '')
      expect(m).to_not be_valid
    end
  end

end
