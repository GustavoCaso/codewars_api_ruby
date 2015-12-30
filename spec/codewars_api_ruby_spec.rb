require 'spec_helper'

describe CodewarsApiRuby do
  context 'User' do
    let :user_request do
      VCR.use_cassette 'user' do
        described_class.user(username_or_id: 'GustavoCaso')
      end
    end
    subject { user_request }
    it 'will return a valid user object' do
      expect(subject).to be_a CodewarsApiRuby::User
    end

    it_should_behave_like 'user_methods'
  end

  context 'NextKata' do
    let :next_kata_request do
      VCR.use_cassette 'next_kata' do
        described_class.next_kata(language: :ruby)
      end
    end

    subject { next_kata_request }
    it 'will return a valid next_kata object' do
      expect(next_kata_request).to be_a CodewarsApiRuby::NextKata
    end

    it_should_behave_like 'next_kata_methods'
  end
end
