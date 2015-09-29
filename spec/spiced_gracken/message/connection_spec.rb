require 'spec_helper'

describe SpicedGracken::Message::Connection do
  let(:klass) { SpicedGracken::Message::Connection }

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
      SpicedGracken::ActiveServers.clear!
      msg = klass.new
      msg.payload = {
        'sender' => {
          'name' => 'me',
          'location' => 'here',
          'uid' => '1234'
        }
      }
      msg.display

      expect(SpicedGracken::ActiveServers.count).to eq 1
    end
  end
end
