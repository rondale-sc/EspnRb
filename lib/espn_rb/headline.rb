module EspnRb
  class Headline
    attr_reader :api_key

    def initialize(opts)
      @api_key = opts && opts[:api_key].nil? ? opts[:api_key] : ENV['espn_api_key']
      raise StandardError, "You must specify an API key." if @api_key.nil?
      create_headline_methods
    end

    def api_resources
      @api_resources ||= YAML::load(File.read('lib/espn_rb/api_definitions/headline_resources.yaml'))
    end

    def api_methods
      @api_methods ||= YAML::load(File.read('lib/espn_rb/api_definitions/headline_methods.yaml'))
    end

    def get_results(resource, method)
      http = Net::HTTP.new("api.espn.com")
      request = Net::HTTP::Get.new("/#{EspnRb::API_VERSION}#{resource}#{method}?apikey=#{@api_key}")
      HeadlineResponse.new JSON.parse(http.request(request).body)
    end

    def create_headline_methods
      api_resources.each do |k,v|
        define_singleton_method(k) do |opt=nil|
          get_results(v[:url], get_api_method(opt))
        end
      end
    end

    def get_api_method(opt)
      case opt.class.to_s
      when "Symbol"
        api_method = api_methods.keys.include?(opt) ? api_methods[opt][:url] : (raise StandardError, "The parameter you sent is not available.")
      when "Hash"
        api_method = opt_from_hash(opt)
      else
        api_method = api_methods[:news][:url]
      end
    end

    def opt_from_hash(opt)
      if !opt[:for_date].nil?
        for_date opt
      elsif !opt[:for_athlete].nil?
        for_athlete opt
      end
    end

    def for_athlete(opt)
      api_methods[:for_athlete][:url].gsub(":athleteId", opt[:for_athlete])
    end

    def for_date(opt)
      api_methods[:for_date][:url].gsub(":yyyymmdd", Date.parse(opt[:for_date]).strftime("%Y%m%d"))
    end

    def help
       EspnRb::Utilities.help api_resources.map {|k,v| "\t#{(':' + k.to_s).ljust(25)} #{v[:description]}"}.join("\n")
    end
  end
end