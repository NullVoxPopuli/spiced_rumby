require 'spec_helper'

describe SpicedGracken::Message::NodeListDiff do
  let(:klass) { SpicedGracken::Message::NodeListDiff }

  before(:each) do
    mock_settings_objects
  end

  context 'instantiation' do
    it 'sets a default payload' do
      msg = klass.new
      expect(msg.payload).to_not be_nil
    end
  end

  context '#handle' do
    it 'adds node entries we do not have' do
      msg = klass.new(message: [
          {
            'alias' => 'hi',
            'location' => '2.2.2.2:222',
            'uid' => '222',
            'publicKey' => '1233333'
          }
        ])

      expect{
        msg.handle
      }.to change(SpicedGracken::Models::Entry, :count).by 1
    end
  end
end
