require 'codewars_api_ruby/object_builder'

module CodewarsApiRuby
  class AttemptSolution
    include ObjectBuilder

    def initialize(data:)
      _build_object(data)
    end
  end
end
