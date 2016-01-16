require 'spec_helper'

describe CodewarsClient::Configuration do
  CodewarsClient::Configuration::PUBLIC_METHODS.each do |method|
    describe "##{method}" do
      it 'should respond_to' do
        expect(CodewarsClient.respond_to?(method)).to be_truthy
      end
    end
  end
end
