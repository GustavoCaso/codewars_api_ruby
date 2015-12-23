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

  it 'fail missing api key' do
    expect{
      described_class.get path: 'foo', params: 'bar'
    }.to raise_error CodewarsApiRuby::Client::ApiKeyMissingError
  end
end
