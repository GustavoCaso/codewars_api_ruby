require 'codewars_api_ruby/object_builder'

module CodewarsApiRuby
  class NextKata
    include ObjectBuilder
    PATH = 'code-challenges'

    def initialize(data:)
      _build_object(data)
    end
  end
end
