require "espn_rb/version"
require "espn_rb/headline.rb"
require 'espn_rb/headline_response.rb'

require 'json'
require "net/http"

module EspnRb
  def self.headlines(options=nil)
    EspnRb::Headline.new(options)
  end
end
