require 'spec_helper'

describe SpicedGracken::Message::Whisper do
  let(:klass) { SpicedGracken::Message::Whisper }

  context 'instantiation' do
    it 'sets a default payload' do
      msg = klass.new
      expect(msg.payload).to_not be_nil
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
