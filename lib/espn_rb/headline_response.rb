class HeadlineResponse
  attr_reader :response

  def initialize(response)
    @response = response
    @reports = create_reports(reponse)
  end

  def method_missing(sym, *args)
    sym.to_s == "titles"? sym = :headlines : sym

    if %w{headlines descriptions sources bylines types}.include?(sym.to_s)
      @response["headlines"].map {|h| h[sym.to_s[0..-2]]  }
    end
  end
end