require 'codewars_api_ruby/object_builder'

module CodewarsApiRuby
  class User
    include ObjectBuilder
    PATH = 'users'

    def initialize(data:)
      _build_object(data)
    end
  end
end
