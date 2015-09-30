require 'spec_helper'

describe SpicedGracken::Message::Disconnection do
  let(:klass) { SpicedGracken::Message::Disconnection }

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
          'name' => 'me',
          'location' => 'here'
        }
      }

      expect(msg.display).to include('me@here has disconnected')
    end
  end
end
