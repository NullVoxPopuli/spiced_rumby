require 'spec_helper'

describe SpicedGracken::Config::Settings do
  let(:klass) { SpicedGracken::Config::Settings }

  it 'sets the default if there is no settings file' do
    allow_any_instance_of(klass).to receive(:exists?) { false }

    s = klass.new
    expect(s.as_hash).to eq klass::DEFAULT_SETTINGS
  end

  it 'sets the default if there is a settings file' do
    allow_any_instance_of(klass).to receive(:exists?) { true }

    s = klass.new
    expect(s.as_hash).to eq klass::DEFAULT_SETTINGS
  end
end
