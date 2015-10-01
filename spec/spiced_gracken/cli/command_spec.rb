require 'spec_helper'

describe SpicedGracken::CLI::Command do
  let (:klass){ SpicedGracken::CLI::Command }

  before(:each) do
    mock_settings_objects
  end

  describe '#handle' do
    it 'is not implemented' do
      i = klass.new('/blegh')
      expect(i.handle).to eq 'not implemented...'
    end

    it 'is implemented' do
      i = klass.new('/config set')
      expect(i.handle).to_not eq 'not implemented...'
    end
  end

  describe '#sub_command_args' do
    it 'returns args of a sub command' do
      i = klass.new('/config set alias something')
      expect(i.send(:sub_command_args)).to eq ['alias', 'something']
    end
  end

end
