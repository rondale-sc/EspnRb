require "espn_rb/version"
require "espn_rb/headline.rb"
require 'espn_rb/headline_response.rb'
require 'espn_rb/headline_item.rb'
require 'espn_rb/headline_image.rb'
require 'espn_rb/utilities.rb'

require 'json'
require "net/http"

module EspnRb
  include EspnRb::Utilities

  # Returns an EspnRb::Headline object.
  #
  # @param [Hash] options the options to create the Headline object.
  # @option options [String] :api_key Your ESPN developer api key.
  # @return [EspnRb::Headline] entry point to Espn Headline API.
  def self.headlines(options=nil)
    EspnRb::Headline.new(options)
  end
end
