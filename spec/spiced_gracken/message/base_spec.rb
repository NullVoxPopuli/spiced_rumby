require 'spec_helper'

describe SpicedGracken::Message::Base do
  let(:klass) { SpicedGracken::Message::Base }

  before(:each) do
    mock_settings_objects
  end

  describe '#display' do
    it 'alerts the need to implement' do
      m = klass.new
      expect(m.display).to eq 'not implemented... you must implement display'
    end
  end

end
