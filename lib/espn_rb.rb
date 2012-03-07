require "espn_rb/version"
require "espn_rb/headline.rb"
require 'json'
require "net/http"

class EspnRb
  include Headline

  attr_reader :api_key

  def initialize(opts=nil)
    @api_key = opts && oepts[:api_key].nil? ? opts[:api_key] : ENV['espn_api_key']
  end
end
