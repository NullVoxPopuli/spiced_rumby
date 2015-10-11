require 'spec_helper'

describe SpicedGracken::CLI::Ping do
  let (:klass){ SpicedGracken::CLI::Ping }

  before(:each) do
    mock_settings_objects
  end

  describe '#handle' do
    before(:each) do
      allow(SpicedGracken::Http::Client).to receive(:dispatch){}
    end

    it 'cannot find the server' do
      c = klass.new('/ping alias noone')
      expect(c.handle).to eq ('noone could not be found')
    end

    it 'shows usage' do
      c = klass.new('/ping')
      expect(c.handle).to eq c.usage
    end

    it 'tries to send' do
      c = klass.new('/ping location noone')
      # does not return when sending
      expect(c.handle).to eq 'noone could not be found'
    end
  end

  describe '#lookup_field' do
    it 'is the subcommand' do
      c = klass.new('/ping alias')
      expect(c.lookup_field).to eq c.send(:sub_command)
    end

    it 'is null if not present' do
      c = klass.new('/ping')
      expect(c.lookup_field).to eq nil
    end
  end

  describe '#lookup_value' do
    it 'is the last arg' do
      c = klass.new('/ping alias me')
      expect(c.lookup_value).to eq 'me'
    end

    it 'retuns nil if there is no value' do
      c = klass.new('/ping location')
      expect(c.lookup_value).to be_nil
    end
  end

  describe '#parse_ping_command' do
    it 'when lookup field is specified' do
      c = klass.new('/ping location 1.1.1.1')
      expect(c.parse_ping_command).to eq ['location', '1.1.1.1']
    end

    it 'when only an location is specified' do
      c = klass.new('/ping 1.1.1.1')
      expect(c.parse_ping_command).to eq ['location', '1.1.1.1']
    end

    it 'is an alias' do
      c = klass.new('/ping me')
      expect(c.parse_ping_command).to eq ['alias', 'me']
    end
  end
end
