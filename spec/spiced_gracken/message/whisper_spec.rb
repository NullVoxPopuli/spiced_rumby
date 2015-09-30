require 'spec_helper'

describe SpicedGracken::Message::Whisper do
  let(:klass) { SpicedGracken::Message::Whisper }

  context 'instantiation' do
    it 'sets a default payload' do
      msg = klass.new
      expect(msg.payload).to_not be_nil
    end

    it 'sets the default sender' do
      m = klass.new
      expect(m.sender_name).to eq SpicedGracken::Settings['alias']
      expect(m.sender_location).to eq SpicedGracken::Settings.location
      expect(m.sender_uid).to eq SpicedGracken::Settings['uid']
    end
  end

  context 'display' do
    it 'does not show to on received whispers' do
      msg = klass.new
      s = msg.display
      expect(s).to_not include('->')
    end

    it 'does show the to' do
      msg = klass.new(to: 'you')
      s = msg.display
      expect(s).to include('->')
    end
  end
end
