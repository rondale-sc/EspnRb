class HeadlineResponse
  class HeadlineItem
    attr_reader :headline

    def initialize(opts)
      @headline = opts
    end

    def web_url(mobile=false)
      (mobile == true) ? @headline["links"]["mobile"]["href"] : @headline["links"]["web"]["href"]
    end

    def title
      @headline["headline"]
    end

    def id
      @headline["id"]
    end

    def api_url
      @headline["links"]["api"]["news"]["href"]
    end

    def collect_category(sym)
      @headline["categories"].inject([]) {|m, i| m <<  i[sym.to_s] unless i[sym.to_s].nil?; m}
    end

    def athletes
      return collect_category(:description)
    end

    def leagues
      return collect_category(:leagueId)
    end

    def athlete_ids
      return collect_category(:athleteId)
    end

    def categories
      @headline["categories"]
    end
  end
end