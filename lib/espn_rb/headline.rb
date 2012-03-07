module Headline
  def resources
    YAML::load(File.read('lib/espn_rb/headline_resources.yaml'))
  end

  def methods
    YAML::load(File.read('lib/espn_rb/headline_methods.yaml'))
  end

  def get_results(resource, method)
    http = Net::HTTP.new("api.espn.com")
    request = Net::HTTP::Get.new("#{resource}#{method}?apikey=#{api_key}")
    http.request(request)
  end

  def all_headlines(opts=nil)
    response = get_results(resources[:professional][:coed][:all][:relative_url], methods[:news][:relative_url])

    if response.class == Net::HTTPOK
      JSON.parse(response.body)
    end
  end

  def api_key
    super
  end
end