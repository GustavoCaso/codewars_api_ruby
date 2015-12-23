module CodewarsApiRuby
  module Configuration
    PUBLIC_METHODS = [:api_key]

    API_VERSION = 'v1'
    DEFAULT_ENDPOINT = "https://www.codewars.com/api/#{API_VERSION}"

    API_KEY_DEFAULT = nil

    attr_accessor *PUBLIC_METHODS

    def self.extended(base)
      base.reset
    end

    def reset
      self.api_key = API_KEY_DEFAULT
    end

    def configure
      yield self
    end
  end
end
