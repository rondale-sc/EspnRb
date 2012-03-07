require 'spec_helper'

describe EspnRb do

  before(:each) do
    @espn = EspnRb.new

    # Stub request for valid #all_headlines call
    stub_request(:get, "http://api.espn.com/sports/news?apikey=#{@espn.api_key}").to_return(
                    :status => 200,
                    :body => File.read('spec/mock_requests/all_headlines_request.txt'),
                    :headers => {})
  end

  it "should return valid Hash when #all_headlines is called." do
    @espn.all_headlines.class.should eq(Hash)
  end

  specify { @espn.resources.class.should eq(Hash) }
  specify { @espn.methods.class.should eq(Hash) }

  it "get_results from api.espn.com" do
    @espn.get_results(@espn.resources[:professional][:coed][:all][:relative_url], @espn.methods[:news][:relative_url]).class.should eq(Net::HTTPOK)
  end
end