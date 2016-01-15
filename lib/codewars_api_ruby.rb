require "codewars_api_ruby/finalize"
require "codewars_api_ruby/deferred_response"
require "codewars_api_ruby/attempt_solution"
require "codewars_api_ruby/next_kata"
require "codewars_api_ruby/user"
require "codewars_api_ruby/client"
require "codewars_api_ruby/configuration"
require "codewars_api_ruby/version"
require 'json'

module CodewarsApiRuby
  class InvalidLanguageSelection < StandardError; end
  extend Configuration
  extend Client

  VALID_LANGUAGES = [
    :clojure, :coffescript, :c, :haskell, :java, :javascript, :pythom, :ruby
  ]

  class << self
    def user(username_or_id:)
      status, response = get(path: User::PATH, params: username_or_id)
      User.new(data: _parse_response(status, response))
    end

    def next_kata(language:)
      fail InvalidLanguageSelection unless VALID_LANGUAGES.include?(language.to_sym)
      status, response = post(path: NextKata::PATH, params: [language.to_s, 'train'])
      NextKata.new(data: _parse_response(status, response))
    end

    def attemp_solution(kata:, code:)
      status, response = post(path: NextKata::PATH,
        params: ['projects', kata.project_id, 'solutions', kata.solution_id, 'attempt'],
        body: code
      )
      AttemptSolution.new(data: _parse_response(status, response))
    end

    def deferred_response(dmid:)
      status, response = get(path: DeferredResponse::PATH, params: dmid)
      DeferredResponse.new(data: _parse_response(status, response))
    end


    def finalize(kata:)
      status, response = post(path: NextKata::PATH,
        params: ['projects', kata.project_id, 'solutions', kata.solution_id, 'finalize']
      )
      Finalize.new(data: _parse_response(status, response))
    end

    private

    def _parse_response(status, response)
      JSON.parse(response).merge({'status' => status})
    end
  end
end
