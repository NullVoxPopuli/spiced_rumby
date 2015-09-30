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

  describe '#new' do
    it 'has my sender defaults' do
      m = klass.new
      expect(m.sender_name).to eq SpicedGracken::Settings['alias']
      expect(m.sender_location).to eq SpicedGracken::Settings.location
      expect(m.sender_uid).to eq SpicedGracken::Settings['uid']
    end
  end

end
