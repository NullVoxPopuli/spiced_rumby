require 'spec_helper'

describe SpicedGracken::Config::HashFile do
  let(:klass) { SpicedGracken::Config::HashFile }

  before(:each) do
    allow_any_instance_of(klass).to receive(:filename) { 'blegh' }
    allow_any_instance_of(klass).to receive(:save) {}
  end

  it 'sets the default if there is no settings file' do
    s = klass.new

    expect(s.as_hash).to eq klass::DEFAULT_SETTINGS
  end

  describe 'instance methods' do
    let(:instance) { klass.new }

    it 'sets like a hash of indifferent access' do
      instance[:key] = 'value'

      expect(instance['key']).to eq 'value'
    end

    it 'returns the underlying hash' do
      instance._hash = hash = { key: :value }
      expect(instance.as_hash).to eq hash
    end

    it 'sets the value' do
      instance.set(:key, with: 'value')
      expect(instance['key']).to eq 'value'
    end
  end
end
