require 'spec_helper'

describe CodewarsApiRuby::Configuration do
  CodewarsApiRuby::Configuration::PUBLIC_METHODS.each do |method|
    describe "##{method}" do
      it 'should respond_to' do
        expect(CodewarsApiRuby.respond_to?(method)).to be_truthy
      end
    end
  end
end
