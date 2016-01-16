require "codewars_client/finalize"
require "codewars_client/deferred_response"
require "codewars_client/attempt_solution"
require "codewars_client/next_kata"
require "codewars_client/user"
require "codewars_client/client"
require "codewars_client/configuration"
require "codewars_client/version"
require 'json'

module CodewarsClient
  class InvalidLanguageSelection < StandardError; end
  extend Configuration
  extend Client

  VALID_LANGUAGES = [
    :clojure, :coffescript, :c, :haskell, :java, :javascript, :python, :ruby
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
