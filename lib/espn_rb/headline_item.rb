class HeadlineResponse
  class HeadlineItem
    attr_reader :headline

    def initialize(opts)
      @headline = opts
    end

    # @example
    #   espn = EspnRb.headlines
    #   espn.nba.first.web_url => "http://some-valid-nba-article"
    # @return [String] web_url for Item
    def web_url(mobile=false)
      (mobile == true) ? @headline["links"]["mobile"]["href"] : @headline["links"]["web"]["href"]
    end

    # @example
    #   espn = EspnRb.headlines
    #   espn.ncaa_football.first.title => "Gators Win!!"
    # @return [String] title for Item
    def title
      @headline["headline"]
    end

    # @example
    #   espn = EspnRb.headlines
    #   espn.ncaa_football.first.description => "Some string about what happened in the article."
    # @return [String] description for Item
    def description
      @headline["description"]
    end

    # @example
    #   espn = EspnRb.headlines
    #   espn.ncaa_football.first.source => "Page 2"
    # @return [String] source for Item
    def source
      @headline["source"]
    end

    # @example
    #   espn = EspnRb.headlines
    #   espn.ncaa_football.first.last_modified => "2012-03-16T04:07:56Z"
    # @return [String] title for Item
    def last_modified
      @headline["lastModified"]
    end

    # @example
    #   espn = EspnRb.headlines
    #   espn.ncaa_football.first.id => '1234'
    # @return [Integer] id for Item
    def id
      @headline["id"]
    end

    # @example
    #   espn = EspnRb.headlines
    #   espn.nba.first.api_url => "http://some-valid-nba-article"
    # @return [String] api_url for Item
    def api_url
      @headline["links"]["api"]["news"]["href"]
    end


    def collect_category(sym)
      @headline["categories"].inject([]) {|m, i| m <<  i[sym.to_s] unless i[sym.to_s].nil?; m}
    end

    # Provides access to categories sub-hash.  If available
    #
    # @example
    #   espn = EspnRb.headlines
    #   espn.nba.first.athletes
    # #=> ["Johnny B", "Freddie Flintstone", "Etc"]
    def athletes
      return collect_category(:description)
    end

    # Provides access to categories sub-hash.  If available
    #
    # @example
    #   espn = EspnRb.headlines
    #   espn.nba.first.leagues
    # #=> ["46"]
    def leagues
      return collect_category(:leagueId)
    end

    # Provides access to categories sub-hash.  If available
    #
    # @example
    #   espn = EspnRb.headlines
    #   espn.nba.first.athlete_ids
    # #=> ["123", "132", "123"]
    def athlete_ids
      return collect_category(:athleteId)
    end

    def categories
      @headline["categories"]
    end
  end
end