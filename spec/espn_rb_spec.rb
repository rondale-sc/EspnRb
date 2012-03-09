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

  it "should return valid HeadlineResponse when #all is called." do
    @espn.all.class.should eq(HeadlineResponse)
  end

  it "get_results from api.espn.com" do
    @espn.get_results(@espn.api_resources[:all][:url], @espn.api_methods[:news][:url]).class.should eq(HeadlineResponse)
  end

  describe HeadlineResponse do
    context "returns the correct title information when #title is called" do
     it {@espn.all.titles.first.should eq("Trail Blazers 86, Hornets 74")}
     it {@espn.all.titles.last.should eq("Saint Mary's (Cal) 78, No. 24 Gonzaga 74") }
    end
  end
end

