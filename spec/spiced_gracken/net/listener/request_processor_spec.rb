require 'spec_helper'

describe SpicedGracken::Net::Listener::RequestProcessor do
  let(:klass){ SpicedGracken::Net::Listener::RequestProcessor }


  before(:each) do
    mock_settings_objects
  end

  describe '#update_sender_info' do
    it 'dispatches the server list hash' do
      json = '{
        "type":"chat",
        "message":"gr",
        "client":"Spiced Gracken",
        "client_version":"0.1.2",
        "time_sent":"2015-09-30T13:04:39.019-04:00",
        "sender":{
          "alias":"nvp",
          "location":"10.10.10.10:1010",
          "uid":"100"
        }}'
      data = JSON.parse(json)

      expect_any_instance_of(SpicedGracken::Message::NodeListHash).to receive(:render)
      expect(SpicedGracken::Net::Client).to receive(:send_to)
      klass.update_sender_info(data)
    end

    it 'does not dispatch the server list hash if the message is from an active node' do
      allow_any_instance_of(SpicedGracken::Node).to receive(:all){
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
          "alias":"nvp",
          "location":"10.10.10.10:1010",
          "uid":"100"
        }}'
      data = JSON.parse(json)

      expect_any_instance_of(SpicedGracken::Message::NodeListHash).to_not receive(:render)
      expect(SpicedGracken::Net::Client).to_not receive(:send_to_and_close)
      klass.update_sender_info(data)
    end
  end
end
