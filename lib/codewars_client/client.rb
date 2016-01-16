require 'faraday'
module CodewarsClient
  module Client
    PUBLIC_METHODS = [:get, :post]
    class ApiKeyMissingError < StandardError; end

    PUBLIC_METHODS.each do |method|
      define_method(method) do |path:, params:, body: nil|
        fail ApiKeyMissingError.new(api_key_message) if CodewarsClient.api_key.nil?
        response = request method: method, path: path, params: params, body: body
        [response.status, response.body]
      end
    end

    private
    def conn
      Faraday.new(url: CodewarsClient::Configuration::DEFAULT_ENDPOINT) do |c|
        c.request  :url_encoded
        c.adapter  Faraday.default_adapter
      end
    end

    def request(method:, path:, params:, body:)
      conn.send(method) do |req|
        req.url File.join(path, params)
        req.headers['Authorization'] = CodewarsClient.api_key
        req.body = { code: body } unless body.nil?
      end
    end

    def api_key_message
      'Please set up your api key'
    end
  end
end
