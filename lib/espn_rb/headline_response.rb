class HeadlineResponse
  include Enumerable

  attr_reader :response,:responses

  def initialize(response)
    @response = @response || response
    @responses = @response['headlines'].map {|h| HeadlineItem.new(h)}
    @reports = create_reports(reponse)
  end

  def each &block
    @responses.each do |response|
       if block_given?
        block.call response
      else
        yield response
      end
    end
  end

  def [](int)
    @responses[int]
  end

  def method_missing(sym, *args)
    sym.to_s == "titles" ? sym = :headlines : sym

    if %w{headlines descriptions sources bylines types}.include?(sym.to_s)
      @response["headlines"].map {|h| h[sym.to_s[0..-2]]  }
    end
  end
end