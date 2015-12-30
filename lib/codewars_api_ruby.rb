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
  class ToManyRequest < StandardError; end
  extend Configuration
  extend Client

  VALID_LANGUAGES = [
    :clojure, :coffescript, :c, :haskell, :java, :javascript, :pythom, :ruby
  ]

  class << self
    def user(username_or_id:)
      status, response = get(path: User::PATH, params: username_or_id)
      User.new(data: response)
    end

    def next_kata(language:)
      fail InvalidLanguageSelection unless VALID_LANGUAGES.include?(language)
      status, response = post(path: NextKata::PATH, params: [language.to_s, 'train'])
      NextKata.new(data: response)
    end

    def attemp_solution(kata:, code:)
      status, response = post(path: NextKata::PATH,
        params: ['projects', kata.project_id, 'solutions', kata.solution_id, 'attempt'],
        body: code
      )
      AttemptSolution.new(data: response)
    end

    def deferred_response(dmid:)
      get(path: DeferredResponse::PATH, params: dmid)
    end

    def fetch_deferred_result(dmid:)
      fetching_result = true
      count = 1
      while fetching_result do
        fail ToManyRequest if count > 10
        staus , response = deferred_response(dmid: dmid)
        result = JSON.parse(response)
        if result['success']
          fetching_result = false
          return DeferredResponse.new(data: response)
        end
        count += 1
        sleep 1
      end
    end

    def finalize(defered:, kata:)
      if deferred.valid
        status, response = post(path: NextKata::PATH,
          params: ['projects', kata.project_id, 'solutions', kata.solution_id, 'finalize']
        )
        puts "Correct answer for #{kata.name}"
      else
        warn "Invalid answer for #{kata.name} reason: #{deferred.reason}"
      end
    end
  end
end
