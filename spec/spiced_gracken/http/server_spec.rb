
require 'spec_helper'

describe SpicedGracken::Http::Server do
  let(:klass) { SpicedGracken::Http::Server }

  before(:each) do
    mock_settings_objects
  end

  describe '#update_sender_info' do
    before(:each) do
      allow_any_instance_of(klass).to receive(:listen){}
    end

    it 'dispatches the server list hash' do
      json = '{
        "type":"chat",
        "message":"gr",
        "client":"Spiced Gracken",
        "client_version":"0.1.2",
        "time_sent":"2015-09-30T13:04:39.019-04:00",
        "sender":{
          "name":"nvp",
          "location":"10.10.10.10:1010",
          "uid":"100"
        }}'
      data = JSON.parse(json)

      s = klass.new

      expect_any_instance_of(SpicedGracken::Message::NodeListHash).to receive(:render)
      expect(SpicedGracken::Http::Client).to receive(:send_to_and_close)
      s.update_sender_info(data)
    end

    it 'does not dispatch the server list hash if the message is from an active node' do
      allow_any_instance_of(SpicedGracken::ActiveServers).to receive(:_list){
        [
          SpicedGracken::Node.new(
            uid: '100',
            location: '1.1.1.1:11',
            alias_name: 'hi'
          )
        ]
      }

      json = '{
        "type":"chat",
        "message":"gr",
        "client":"Spiced Gracken",
        "client_version":"0.1.2",
        "time_sent":"2015-09-30T13:04:39.019-04:00",
        "sender":{
          "name":"nvp",
          "location":"10.10.10.10:1010",
          "uid":"100"
        }}'
      data = JSON.parse(json)

      s = klass.new

      expect_any_instance_of(SpicedGracken::Message::NodeListHash).to_not receive(:render)
      expect(SpicedGracken::Http::Client).to_not receive(:send_to_and_close)
      s.update_sender_info(data)
    end
  end

  describe '#processes_message' do
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
          "name":"nvp",
          "location":"localhost:8081",
          "uid":"1"
        }
      }'
      json = JSON.parse(json)

      s = klass.new
      msg = s.processes_message(json)
      expect(msg.display).to include("nvp")
      expect(msg.display).to include("yo")
    end
  end

end
