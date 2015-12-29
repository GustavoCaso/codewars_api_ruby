require "codewars_api_ruby/attempt_solution"
require "codewars_api_ruby/next_kata"
require "codewars_api_ruby/user"
require "codewars_api_ruby/client"
require "codewars_api_ruby/configuration"
require "codewars_api_ruby/version"

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
      fetching_result = true
      count = 1
      while fetching_result do
        status, response = get(path: Deferred::PATH, params: dmid)
        if response['success']
          fetching_result = false
          return DeferredResponse.new(data: response)
        end
        count += 1
        puts "Trying the fetch deferred inforamtion for #{dmid} count: #{count}"
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
