class EspnResponse
  def initialize(response)
    @response = response
  end

  def titles
    @response["headlines"].map {|h| h["headline"] }
  end
end