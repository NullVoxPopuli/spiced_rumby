require 'spec_helper'

describe SpicedGracken::Models::Entry do
  let(:klass) { SpicedGracken::Models::Entry }

  before(:each) do
    mock_settings_objects
  end


  describe 'diff' do
    let(:shared){
      {
        'alias' => 'shared',
        'location' => '1.1.1.1:8000',
        'uid' => '1',
        'publicKey' => 'a'
      }
    }

    let(:ours){
      {
        'alias' => 'ours',
        'location' => '1.1.1.1:8001',
        'uid' => '2',
        'publicKey' => 'b'
      }
    }

    let(:theirs){
      {
        'alias' => 'theirs',
        'location' => '1.1.1.1:8002',
        'uid' => '3',
        'publicKey' => 'c'
      }
    }

    it 'seperates ours from theirs' do
      us = [shared, ours]
      them = [shared, theirs]

      us.each{|e| klass.from_json(e).save }

      we_only_have, they_only_have = klass.diff(them)

      expect(they_only_have).to eq [theirs]
      expect(we_only_have).to eq [ours]
    end

  end

  describe '#==' do
    it 'is equal to a hash of same values' do
      hasherized_json = {
        'alias' => 'alias',
        'location' => '1.1.1.1:8080',
        'uid' => '1',
        'publicKey' => '123'
      }
      m = klass.new(
        alias_name: 'alias',
        location: '1.1.1.1:8080',
        uid: '1',
        public_key: '123')

      expect(m == hasherized_json).to be_truthy
    end
  end

  describe '#as_json' do
    it 'converts to a hash / json' do
      m = klass.new(
        alias_name: 'alias',
        location: '1.1.1.1:8080',
        uid: '1',
        public_key: '123')


      expected = {
        'alias' => 'alias',
        'location' => '1.1.1.1:8080',
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

    it 'is false without an location' do
      m = klass.new(location: '')
      expect(m).to_not be_valid
    end

    it 'is false without a uid' do
      m = klass.new(uid: '')
      expect(m).to_not be_valid
    end
  end

end
