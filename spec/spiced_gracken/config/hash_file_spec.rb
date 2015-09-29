require 'spec_helper'

describe SpicedGracken::Config::HashFile do
  let(:klass) { SpicedGracken::Config::HashFile }

  before(:each) do
    mock_settings_objects
  end

  context 'filename is set' do
    before(:each) do
      allow_any_instance_of(klass).to receive(:filename) { 'test-hashfile' }
    end

    it 'sets the default if there is no settings file' do
      s = klass.new
      expect(s.as_hash).to eq klass::DEFAULT_SETTINGS
    end

    context 'instance methods' do
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

      describe '#load' do
        context 'json is valid' do

        end

        context 'json is invalid' do
          before(:each) do
            allow(instance).to receive(:read_file){ '{'}
          end

          it 'shows the error message' do
            expect(SpicedGracken::Display).to receive(:alert)
            expect(SpicedGracken::Display).to receive(:warning)
            instance.load
          end

          it 'writes defaults' do
            instance.load

            expect(instance._hash).to eq instance.default_settings
          end
        end
      end
    end
  end

  describe '#filename' do

    it 'fails' do
      expect{
        klass.new.filename
      }.to raise_error
    end
  end
end
