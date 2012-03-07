require 'spec_helper'

describe EspnRb do

  before(:each) do
    @espn = EspnRb.new
  end

  it "should return 200 response when #all_headlines is called." do
        stub_request(:get, "http://api.espn.com/sports/news?apikey=#{@espn.api_key}").to_return(
                    :status => 200,
                    :body => File.read('spec/mock_requests/all_headlines_request.txt'),
                    :headers => {})

    @espn.all_headlines.class.should eq(Hash)
  end

  it "returns valid espn api resources hash when requested" do
    @espn.resources.class.should eq(Hash)
  end

  it "returns valid espn api methods hash when requested" do
    @espn.methods.class.should eq(Hash)
  end

  it "get_results from api.espn.com" do
    stub_request(:get, "api.espn.com/sports/news").with(:query => {"apikey" => @espn.api_key})

    @espn.get_results(@espn.resources[:professional][:coed][:all][:relative_url], @espn.methods[:news][:relative_url]).class.should eq(Net::HTTPOK)
  end
end