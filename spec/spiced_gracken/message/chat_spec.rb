require 'spec_helper'

describe SpicedGracken::Message::Chat do
  let(:klass) { SpicedGracken::Message::Chat }

  context 'instantiation' do
    it 'sets a default payload' do
      msg = klass.new
      expect(msg.payload).to_not be_nil
    end
  end
end
