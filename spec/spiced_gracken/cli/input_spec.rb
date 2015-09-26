require 'spec_helper'

describe SpicedGracken::CLI::Input do
  let(:klass) { SpicedGracken::CLI::Input }

  before(:each) do
    mock_settings_objects
  end

  context 'create' do
    it 'creates a command' do
      result = klass.create('/anything')
      expect(result).to be_kind_of(SpicedGracken::CLI::Command)
    end

    it 'creates a whisper' do
      result = klass.create('@anybody')
      expect(result).to be_kind_of(SpicedGracken::CLI::Whisper)
    end

    it 'creates a generic input' do
      result = klass.create('chat')
      expect(result).to be_kind_of(klass)
    end
  end
end
