require 'spec_helper'

class TestClass
  extend CodewarsApiRuby::Client
end

describe TestClass do
  CodewarsApiRuby::Client::PUBLIC_METHODS.each do |method|
    it "respond to ##{method}" do
      expect(TestClass.respond_to?(method)).to be_truthy
    end
  end

  context 'Raise ApiKeyMissingError' do
    before do
      @old_value = CodewarsApiRuby.api_key
      CodewarsApiRuby.api_key = nil
    end
    after do
      CodewarsApiRuby.api_key = @old_value
    end
    it do
      expect{
        described_class.get path: 'foo', params: 'bar'
      }.to raise_error CodewarsApiRuby::Client::ApiKeyMissingError
    end
  end
end
