require 'spec_helper'

describe Settings do

  it 'sets the default if there is no settings file' do
    allow_any_instance_of(Settings).to receive(:load){}
    allow_any_instance_of(Settings).to receive(:save){}
    s = Settings.new
    expect(s.settings).to eq Settings::DEFAULT_SETTINGS
  end

  

end
