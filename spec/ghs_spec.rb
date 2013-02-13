require 'ghs'
require 'rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

describe GHS do

  context "#status" do
    it "should return a status response" do
      VCR.use_cassette('status') do
        response = GHS.status
        response['status'].should eql 'good'
        response['last_updated'].should eql '2013-02-13T20:51:09Z'
      end
    end
  end

  context "#last_message" do
    it "should return last_message response" do
      VCR.use_cassette('last-message') do
        response = GHS.last_message
        response['status'].should eql 'good'
        response['body'].should eql 'Live updates are back on, and service hook processing is back to normal.'
        response['created_on'].should eql "2013-02-13T20:03:42Z"
      end
    end
  end

  context "#messages" do
    it "should return messages history" do
      VCR.use_cassette('messages') do
        response = GHS.messages
        response.count.should > 0
        response.first['body'].should eql "Live updates are back on, and service hook processing is back to normal."
        response.first['created_on'].should eql "2013-02-13T20:03:42Z"
        response.first['status'].should eql "good"
      end
    end
  end

end