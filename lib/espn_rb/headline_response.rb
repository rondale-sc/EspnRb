class HeadlineResponse
  attr_reader :response,:responses

  def initialize(response)
    @response = @response || response
    @responses = @response['headlines'].map {|h| HeadlineItem.new(h)}
    @reports = create_reports(reponse)
  end

  def [](int)
    @responses[int]
  end

  def method_missing(sym, *args)
    sym.to_s == "titles"? sym = :headlines : sym

    if %w{headlines descriptions sources bylines types}.include?(sym.to_s)
      @response["headlines"].map {|h| h[sym.to_s[0..-2]]  }
    end
  end

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
  end
end