require 'spec_helper'

describe SpicedGracken::Display::Manager do
  let (:klass){ SpicedGracken::Display::Manager }

  before(:each) do
    mock_settings_objects
  end

  describe '#present_message' do

    it 'invokes chat' do
      expect(SpicedGracken.ui).to receive(:chat)
      m = SpicedGracken::Message::Chat.new
      SpicedGracken::Display.present_message(m)
    end

    it 'invokes whisper' do
      expect(SpicedGracken.ui).to receive(:whisper)
      m = SpicedGracken::Message::Whisper.new
      SpicedGracken::Display.present_message(m)
    end

    it 'invokes info' do
      expect(SpicedGracken.ui).to receive(:info)
      m = SpicedGracken::Message::PingReply.new
      SpicedGracken::Display.present_message(m)
    end

    it 'invokes add_line for other menssages' do
      expect(SpicedGracken.ui).to receive(:add_line)
      m = SpicedGracken::Message::Ping.new
      SpicedGracken::Display.present_message(m)
    end
  end

end
