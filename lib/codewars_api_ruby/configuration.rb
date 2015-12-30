module CodewarsApiRuby
  module Configuration
    PUBLIC_METHODS = [:api_key]

    API_VERSION = 'v1'
    DEFAULT_ENDPOINT = "https://www.codewars.com/api/#{API_VERSION}"

    API_KEY_DEFAULT = nil

    attr_accessor *PUBLIC_METHODS

    def configure
      yield self
    end
  end
end
