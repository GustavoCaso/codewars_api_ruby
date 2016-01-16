require 'spec_helper'

class TestClass
  extend CodewarsClient::Client
end

describe TestClass do
  CodewarsClient::Client::PUBLIC_METHODS.each do |method|
    it "respond to ##{method}" do
      expect(TestClass.respond_to?(method)).to be_truthy
    end
  end

  context 'Raise ApiKeyMissingError' do
    before do
      @old_value = CodewarsClient.api_key
      CodewarsClient.api_key = nil
    end
    after do
      CodewarsClient.api_key = @old_value
    end
    it do
      expect{
        described_class.get path: 'foo', params: 'bar'
      }.to raise_error CodewarsClient::Client::ApiKeyMissingError
    end
  end
end
