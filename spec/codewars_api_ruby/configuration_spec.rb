require 'spec_helper'

describe CodewarsApiRuby::Configuration do
  CodewarsApiRuby::Configuration::PUBLIC_METHODS.each do |method|
    describe "##{method}" do
      it 'should return the default value' do
        expect(CodewarsApiRuby.send(method)).to eq CodewarsApiRuby::Configuration.const_get("#{method.upcase}_DEFAULT")
      end
    end
  end
end
