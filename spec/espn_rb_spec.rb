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

  it "#all should return valid HeadlineResponse" do
    @espn.all.class.should eq(HeadlineResponse)
  end

  it "#get_results from api.espn.com" do
    @espn.get_results(@espn.api_resources[:all][:url], @espn.api_methods[:news][:url]).class.should eq(HeadlineResponse)
  end

  it "@api_key should be set" do
    espn = EspnRb.headlines(:api_key => "abc123")
    espn.api_key.should eq "abc123"
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
    context "Method missing provides correct collection methods." do
     it {@espn.all.titles.first.should eq("Trail Blazers 86, Hornets 74")}
     it {@espn.all.descriptions.last.should eq("With the score deadlocked in overtime and the ball bouncing free, opposing guards Matthew Dellavedova and Kevin Pangos collided near the scorer's table.") }
     it {@espn.all.sources.last.should eq("Associated Press") }
     it {@espn.all.types.last.should eq("Wire") }
    end
  end

  describe HeadlineResponse::HeadlineItem do
    context "HeadlineItem returns proper item info when requested" do
     it { @espn.all[1].web_url.should  == 'http://sports.espn.go.com/espn/wire?section=nhl&id=7651009&ex_cid=espnapi_public' }
     it { @espn.all[1].title.should  == 'Oilers-Sharks Preview' }
     it { @espn.all[1].api_url.should  == 'http://api.espn.com/v1/sports/news/7651009' }
     it { @espn.all[1].id.should  == 7651009 }
     it { @espn.all[1].title.should == "Oilers-Sharks Preview" }
     it { @espn.all[1].description.should  == "The San Jose Sharks are trying to reverse what's becoming a free fall through the Western Conference standings."}
     it { @espn.all[1].source.should == "Associated Press"}
     it { @espn.all[1].last_modified.should == "2012-03-06T06:55:01Z"}
    end

    context "HeadlineItem should return an array of requested entries from categories sub-hash" do
      it {@espn.all[1].athletes.should == ["NHL", "San Jose Sharks", "Edmonton Oilers", "Douglas Murray",
                                           "Logan Couture", "Patrick Marleau", "Joe Thornton", "Anaheim Ducks",
                                           "Jordan Eberle", "Shawn Horcoff", "Taylor Hall"] }

      it {@espn.all[1].leagues.should == [90] }
      it {@espn.all[1].athlete_ids.should  == [2100, 3773, 576, 939, 5032, 1080, 5428] }
    end
  end
end

