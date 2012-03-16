module EspnRb
  class Headline
    attr_reader :api_key

    # @raise [StandardError] Will raise StandardError if api_key isn't specified by either options passed into initialize or set from ENV
    def initialize(opts)
      @api_key = opts && !opts[:api_key].nil? ? opts[:api_key] : ENV['espn_api_key']
      raise StandardError, "You must specify an API key." if @api_key.nil?

      create_headline_methods
    end

    # Returns the ESPN resources as defined [here](http://developer.espn.com/docs/headlines#parameters).
    #
    # @return [Hash] of sports, urls and their descriptions.
    def api_resources
      @api_resources ||= YAML::load(File.read(File.expand_path(File.join(File.dirname(__FILE__), "..", 'espn_rb/api_definitions/headline_resources.yaml'))))
    end

    # Returns the ESPN methods as defined [here](http://developer.espn.com/docs/headlines#parameters).
    #
    # @return [Hash] methods, and their associated urls and brief description.
    def api_methods
      @api_methods ||= YAML::load(File.read(File.expand_path(File.join(File.dirname(__FILE__), "..", 'espn_rb/api_definitions/headline_methods.yaml'))))
    end

    # The final request to ESPN api after all option parsing has been completed.
    # @return [HeadlineResponse] a headline response object.
    def get_results(resource, method)
      http = Net::HTTP.new("api.espn.com")
      request = Net::HTTP::Get.new("/#{EspnRb::API_VERSION}#{resource}#{method}?apikey=#{@api_key}")
      HeadlineResponse.new JSON.parse(http.request(request).body)
    end

    # This will define singleton methods for all resources defined
    # in EspnRb::Headline#api_resources
    #
    # @return [HeadlineResponse] which contains the espn response object and assocated methods.
    def create_headline_methods
      api_resources.each do |k,v|
        define_singleton_method(k) do |opt=nil|
          get_results(v[:url], get_api_method(opt))
        end
      end
    end

    # Attempts to parse which EspnRb::Headline.api_methods the user has passed to
    # method defined by EspnRb::Headline.create_headline_methods.
    #
    # @param [Hash] options the options passed in by user.
    # @note This will accept either a string or a hash.
    #
    # @example Call with string
    #   get_api_method("news") #=> '/news'
    #
    # @example Call with Hash (for_date)
    #   get_api_method({:for_date => "2012-01-01"}) #=> '/news/dates/20120101'
    # @option options [String] :arg When string is passed and :arg
    #   is available it will return the url associated with that :arg from EspnRb::Headline.api_methods
    # @option options [Hash] :arg When Hash will pass :arg to opt_from_hash
    #
    # @return [String] a url entry from EspnRb::Headline.api_methods defaults to :news
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

    # Takes EspnRb::Headline.api_methods[:for_athlete][:url] and subs out the options passed by user
    # @example internal call
    #   for_athlete({:for_athlete => "123"}) => '/athletes/123/news'
    def for_athlete(opt)
      api_methods[:for_athlete][:url].gsub(":athleteId", opt[:for_athlete])
    end

    # Takes EspnRb::Headline#api_methods[:for_date][:url] and subs out the options passed by user
    # @example internal call
    #   for_date({:for_date => "2012-01-01"}) => '/news/dates/20120101'
    def for_date(opt)
      api_methods[:for_date][:url].gsub(":yyyymmdd", Date.parse(opt[:for_date]).strftime("%Y%m%d"))
    end

    # Provides help text.  Passes the methods available from create_headline_methods all prettified into a set of
    # strings and passes them to EspnRb::Utilities.help which then inserts it below some nice ascii art.
    def help
       EspnRb::Utilities.help api_resources.map {|k,v| "\t#{(':' + k.to_s).ljust(25)} #{v[:description]}"}.join("\n")
    end
  end
end