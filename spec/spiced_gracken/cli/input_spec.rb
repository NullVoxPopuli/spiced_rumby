require 'spec_helper'

describe SpicedGracken::CLI::Input do
  let(:klass) { SpicedGracken::CLI::Input }

  before(:each) do
    mock_settings_objects
  end

  describe '#create' do
    it 'creates a command' do
      result = klass.create('/anything')
      expect(result).to be_kind_of(SpicedGracken::CLI::Command)
    end

    it 'creates a whisper' do
      result = klass.create('@anybody')
      expect(result).to be_kind_of(SpicedGracken::CLI::Whisper)
    end

    it 'creates a generic input' do
      result = klass.create('chat')
      expect(result).to be_kind_of(klass)
    end
  end

  describe '#handle' do
    it 'has no servers' do
      i = klass.new('hi there')
      expect(i.handle).to eq 'you have no servers'
    end

    context 'has servers' do
      before(:each) do
        allow(SpicedGracken::Node).to receive(:all){
          [
            SpicedGracken::Models::Entry.new(
              alias_name: 'test',
              location: '1.1.1.1:1111',
              uid: '1',
              public_key: '10'
            )
          ]
        }
        allow(SpicedGracken::Net::Client).to receive(:send_to_and_close){}

        # expect(SpicedGracken::Net::Client).to receive(:send_to_and_close)
      end

      it 'displays the message' do
        msg = 'hi test'
        expect(SpicedGracken::Display).to receive(:chat)
        i = klass.new(msg)
        i.handle
      end

      it 'renders the message to json' do
        msg = 'hi test'
        expect_any_instance_of(SpicedGracken::Message::Chat).to receive(:display)
        i = klass.new(msg)
        i.handle
      end
    end
  end
end
