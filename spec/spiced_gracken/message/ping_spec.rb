require 'spec_helper'

describe SpicedGracken::Message::Ping do
  let(:klass) { SpicedGracken::Message::Ping }

  before(:each) do
    mock_settings_objects
  end

  context 'instantiation' do
    it 'sets a default payload' do
      msg = klass.new
      expect(msg.payload).to_not be_nil
    end
  end

  context 'display' do
    it 'displays who pinged' do
      msg = klass.new
      msg.payload = {
        'sender' => {
          'alias' => 'me',
          'location' => 'here'
        }
      }

      expect(msg.display).to include('me@here pinged you.')
    end
  end

  context '#handle' do
    it 'calls respond' do
      msg = klass.new
      msg.payload = {
        'sender' => {
          'alias' => 'me',
          'location' => 'here'
        }
      }
      expect(msg).to receive(:respond)
      expect(msg.handle).to include('me@here pinged you.')
    end
  end

  context 'respond' do
    it 'shoots off a ping reply to the sender of the ping' do
      expect(SpicedGracken::Net::Client).to receive(:send)

      msg = klass.new
      msg.respond
    end
  end
end
