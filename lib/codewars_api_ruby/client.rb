require 'faraday'
module CodewarsApiRuby
  module Client
    class ApiKeyMissingError < StandardError; end
    [:get, :post].each do |method|
      define_method(method) do |path:, params:|
        fail ApiKeyMissingError.new(api_key_message) if CodewarsApiRuby.api_key.nil?
        response = request method: method, path: path, params: params
        [response.status, response.body]
      end
    end

    private
    def conn
      Faraday.new(url: CodewarsApiRuby::Configuration::DEFAULT_ENDPOINT) do |c|
        c.response :logger
        c.adapter  Faraday.default_adapter
      end
    end

    def request(method:, path:, params:)
      conn.send(method) do |req|
        req.url File.join(path, params)
        req.headers['Authorization'] = CodewarsApiRuby.api_key
        req.headers['Content-type'] = 'application/json'
      end
    end

    def api_key_message
      'Please set up your api key'
    end
  end
end
