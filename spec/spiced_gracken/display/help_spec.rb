require 'spec_helper'

describe SpicedGracken::Display::Help do
  let (:klass){ SpicedGracken::Display::Help }

  describe '#welcome' do
    it 'does not error' do
      expect{
        klass.welcome
      }.to_not raise_error
    end
  end

  describe '#hit_key' do
    it 'does not error' do
      expect{
        klass.hit_key
      }.to_not raise_error
    end
  end

end
