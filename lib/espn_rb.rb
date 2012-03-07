require "espn_rb/version"
require "espn_rb/headline.rb"
require 'espn_rb/espn_response.rb'
require 'json'
require "net/http"

class EspnRb
  include Headline

  attr_reader :api_key

  def initialize(opts=nil)
    @api_key = opts && opts[:api_key].nil? ? opts[:api_key] : ENV['espn_api_key']

    raise StandardError, "You must specify an API key." if @api_key.nil?
  end
end
