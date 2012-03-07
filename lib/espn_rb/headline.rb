module EspnRb
  module Headline
    def resources
      YAML::load(File.read('lib/espn_rb/headline_resources.yaml'))
    end

    def methods
      YAML::load(File.read('lib/espn_rb/headline_methods.yaml'))
    end

    def get_results(resource, method)
      http = Net::HTTP.new("api.espn.com")
      request = Net::HTTP::Get.new("#{resource}#{method}?apikey=#{EspnRb.api_key}")
      http.request(request)
    end

    def all_headlines
      get_results(resources[:professional][:coed][:all][:relative_url], methods[:news][:relative_url])
    end

    extend self
  end
end