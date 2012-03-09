require 'spec_helper'

describe EspnRb::Headline do
  before(:each) do
    @espn = EspnRb.headlines

    # Stub request for valid #all_headlines call
    stub_request(:get, "http://api.espn.com/v1/sports/news?apikey=#{@espn.api_key}").to_return(
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

  context "api_resources and api_methods should be defined properly (Ensure no typos)" do
    it {@espn.api_resources[:nba][:url].should eq("/sports/basketball/nba") }
    it {@espn.api_resources[:all][:url].should eq("/sports") }
    it {@espn.api_resources[:golf][:url].should eq("/sports/golf") }
    it {@espn.api_resources[:boxing][:url].should eq("/sports/boxing") }
    it {@espn.api_resources[:mma][:url].should eq("/sports/mma") }
    it {@espn.api_resources[:racing][:url].should eq("/sports/racing") }
    it {@espn.api_resources[:soccer][:url].should eq("/sports/soccer") }
    it {@espn.api_resources[:tennis][:url].should eq("/sports/tennis") }
    it {@espn.api_resources[:mlb][:url].should eq("/sports/baseball/mlb") }
    it {@espn.api_resources[:nfl][:url].should eq("/sports/football/nfl") }
    it {@espn.api_resources[:nhl][:url].should eq("/sports/hockey/nhl") }
    it {@espn.api_resources[:nascar][:url].should eq("/sports/racing/nascar") }
    it {@espn.api_resources[:wnba][:url].should eq("/sports/basketball/wnba") }
    it {@espn.api_resources[:ncaa_basketball][:url].should eq("/sports/basketball/mens-college-basketball") }
    it {@espn.api_resources[:ncaa_football][:url].should eq("/sports/football/college-football") }
    it {@espn.api_resources[:ncaa_womens_basketball][:url].should eq("/sports/basketball/womens-college-basketball") }
  end


  describe HeadlineResponse do
    context "returns the correct title information when #title is called" do
     it {@espn.all.titles.first.should eq("Trail Blazers 86, Hornets 74")}
     it {@espn.all.titles.last.should eq("Saint Mary's (Cal) 78, No. 24 Gonzaga 74") }
    end
  end
end

