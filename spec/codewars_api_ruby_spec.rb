require 'spec_helper'

describe CodewarsApiRuby do

  let :next_kata_request do
    VCR.use_cassette 'next_kata' do
      described_class.next_kata(language: :ruby)
    end
  end

  context 'User' do
    let :user_request do
      VCR.use_cassette 'user' do
        described_class.user(username_or_id: 'GustavoCaso')
      end
    end
    subject { user_request }
    it 'will return a user object' do
      expect(subject).to be_a CodewarsApiRuby::User
    end

    it_should_behave_like 'user_methods'
  end

  context 'NextKata' do
    subject { next_kata_request }
    it 'will return a next_kata object' do
      expect(next_kata_request).to be_a CodewarsApiRuby::NextKata
    end

    it_should_behave_like 'next_kata_methods'
  end

  context 'AttemptSolution' do
    let(:kata) { next_kata_request }
    let(:code) { File.read(File.expand_path('../fixtures/ruby_code_example.rb', __FILE__)) }
    let(:attemp_solution_request) do
      VCR.use_cassette 'attemp_solution' do
        described_class.attemp_solution(kata: kata, code: code)
      end
    end
    it 'should raise error if no code provided' do
      expect{
        described_class.attemp_solution(kata: kata)
      }.to raise_error ArgumentError
    end

    it 'should return a attemp_solution object' do
      expect(attemp_solution_request).to be_a CodewarsApiRuby::AttemptSolution
    end

    context 'DeferredResponse' do
      subject { described_class.deferred_response(dmid: attemp_solution_request.dmid) }

      it 'should return a deferred_response object' do
        VCR.use_cassette 'deferred_response_valid', erb: true do
          expect(subject).to be_a CodewarsApiRuby::DeferredResponse
          expect(subject.success).to be_truthy
        end
      end
    end

    context 'Finalize' do
      subject { described_class.finalize(kata: kata) }

      it 'should return a finalize object' do
        VCR.use_cassette('finalize') do
          expect(subject).to be_a CodewarsApiRuby::Finalize
        end
      end
    end
  end
end
