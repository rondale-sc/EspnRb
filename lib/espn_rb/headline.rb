module Headline
  def api_resources
    @api_resources ||= YAML::load(File.read('lib/espn_rb/headline_resources.yaml'))
  end

  def api_methods
    @api_methods ||= YAML::load(File.read('lib/espn_rb/headline_methods.yaml'))
  end

  def create_headline_readers
    api_resources.each do |k,v|
      define_singleton_method(k) do |opt=nil|
        api_method = api_methods.keys.include?(opt) ? opt : :news
        get_results(v[:url], api_methods[api_method][:url])
      end
    end
  end

  def get_results(resource, method)
    http = Net::HTTP.new("api.espn.com")
    request = Net::HTTP::Get.new("#{resource}#{method}?apikey=#{api_key}")
    HeadlineResponse.new JSON.parse(http.request(request).body)
  end

  def api_key
    super
  end
end