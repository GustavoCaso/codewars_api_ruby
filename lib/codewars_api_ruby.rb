require "codewars_api_ruby/user"
require "codewars_api_ruby/client"
require "codewars_api_ruby/configuration"
require "codewars_api_ruby/version"

module CodewarsApiRuby
  extend Configuration
  extend Client

  def self.user(username_or_id:)
    status, response = get(path: User::PATH, params: username_or_id)
    User.new(data: response)
  end
end
