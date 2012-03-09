require "espn_rb/version"
require "espn_rb/headline.rb"
require 'espn_rb/headline_response.rb'
require 'espn_rb/utilities.rb'

require 'json'
require "net/http"

module EspnRb
  include EspnRb::Utilities

  def self.headlines(options=nil)
    EspnRb::Headline.new(options)
  end
end
