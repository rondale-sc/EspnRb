class HeadlineResponse
  include Enumerable

  attr_reader :response,:responses

  # Sets response from EspnRb::Headline#get_results.  Splits response object into composite parts
  # so that we can include enumerable
  def initialize(response)
    @response  = @response || response
    @responses = @response['headlines'].map {|h| HeadlineItem.new(h)}
  end

  # define each so that Enumerable methods work properly.
  def each &block
    @responses.each do |response|
      if block_given?
        block.call response
      else
        yield response
      end
    end
  end

  # Allows the user to specify which HeadlineItem they'd like to work with via it's index in the @responses array
  #
  # @return [HeadlineItem] HeadlineItem specified by responses index
  def [](int)
    @responses[int]
  end

  # Returns the all the links associated with this HeadlineResponse
  # @option options [String] :type Either web, or mobile.
  # @return [Array] array of links.
  def links(type=nil)
    type = type.nil? ? "web" : type
    @response["headlines"].map{|r| r["links"][type]["href"] }
  end

  # Defines a few collection methods to allow the user to view all of the @response like attributes
  # @note available methods are headlines, descriptions, sources, bylines, types
  #
  # @example Valid method call
  #   EspnRb.headlines.nba.titles #=> ['title1', 'title2', 'title3', 'title4', 'etc']
  # @example Invalid method call
  #   EspnRb.headlines.nba.not_an_available_method #=> nil
  # @return [Array] array of like items or nil
  def method_missing(sym, *args)
    sym.to_s == "titles" ? sym = :headlines : sym

    if %w{headlines descriptions sources bylines types}.include?(sym.to_s)
      @response["headlines"].map {|h| h[sym.to_s[0..-2]]  }
    end
  end
end