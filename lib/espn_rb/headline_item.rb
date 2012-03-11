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

    def categories
      @headline["categories"]
    end
  end
end