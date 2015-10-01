require 'spec_helper'

describe SpicedGracken::Display::Base do
  let(:klass) { SpicedGracken::Display::Base }

  context 'methods are not implemented' do
    it 'must implement start' do
      expect{ klass.new.start }.to raise_error
    end

    it 'must implement add_line' do
      expect{ klass.new.add_line('text') }.to raise_error
    end

    it 'must implement whisper' do
      expect{ klass.new.whisper('text') }.to raise_error
    end

    it 'must implement log' do
      expect{ klass.new.log('text') }.to raise_error
    end
  end

end
