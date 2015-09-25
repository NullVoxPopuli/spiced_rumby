require 'spec_helper'

describe SpicedGracken::Message::PingReply do
  let(:klass) { SpicedGracken::Message::PingReply }


  before(:each) do
    mock_settings_objects
  end

  context 'instantiation' do
    it 'sets a default payload' do
      msg = klass.new
      expect(msg.payload).to_not be_nil
    end
  end
end
