require 'spec_helper'

describe SpicedGracken::Message::Disconnection do
  let(:klass) { SpicedGracken::Message::Disconnection }


  before(:each) do
    allow_any_instance_of(SpicedGracken::Config::ServerList).to receive(:filename) { 'test-serverlist' }
    allow(SpicedGracken).to receive(:server_list) do
      SpicedGracken::Config::ServerList.new
    end

    allow_any_instance_of(SpicedGracken::Config::Settings).to receive(:filename) { 'test-settings' }
    allow(SpicedGracken).to receive(:settings) do
      SpicedGracken::Config::Settings.new
    end

    allow(SpicedGracken).to receive(:active_server_list) do
      SpicedGracken::Config::ActiveServerList.new
    end
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
