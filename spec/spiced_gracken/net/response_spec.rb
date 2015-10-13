require 'spec_helper'

describe SpicedGracken::Net::Response do
  let(:klass) { SpicedGracken::Net::Response }

  before(:each) do
    mock_settings_objects
  end

  describe '#process_json' do
    before(:each) do
      allow_any_instance_of(klass).to receive(:listen){}
    end

    it 'whisper' do
      json = '{
        "type":"whisper",
        "message":"yo",
        "client":"Spiced Gracken",
        "client_version":"0.1.2",
        "time_sent":"2015-09-30 09:04:59 -0400",
        "sender":{
          "alias":"nvp",
          "location":"localhost:8081",
          "uid":"1"
        }
      }'

      s = klass.new(json)
      s.send(:process_json)
      expect(s.message.display).to include("nvp")
      expect(s.message.display).to include("yo")
    end
  end
end
