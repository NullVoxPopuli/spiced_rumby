require 'spec_helper'

describe SpicedGracken::Message::Base do
  let(:klass) { SpicedGracken::Message::Base }

  before(:each) do
    mock_settings_objects
  end

  describe '#display' do
    it 'shows the message' do
      m = klass.new
      expect(m.display).to eq nil # no message
    end
  end

end
