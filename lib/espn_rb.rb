require "espn_rb/version"
require "espn_rb/headline.rb"
require "net/http"

module EspnRb
  attr_writer :api_key

  def api_key
    raise StandardError, "You must specify an API key." unless ENV['espn_api_key']
    ENV['espn_api_key']
  end

  def headline
    EspnRb::Headline if api_key
  end

  extend self
end
