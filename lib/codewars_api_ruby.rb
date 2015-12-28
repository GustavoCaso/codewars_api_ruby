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

  def self.user(username_or_id:)
    status, response = get(path: User::PATH, params: username_or_id)
    User.new(data: response)
  end

  def self.next_kata(language:)
    fail InvalidLanguageSelection unless VALID_LANGUAGES.include?(language)
    status, response = post(path: NextKata::PATH, params: [language.to_s, 'train'])
    NextKata.new(data: response)
  end

  def self.attemp_solution(kata:, code:)
    status, response = post(path: NextKata::PATH,
      params: ['projects', kata.project_id, 'solutions', kata.solution_id, 'attempt'],
      body: code
    )
    binding.pry
    AttemptSolution.new(data: response)
  end
end
