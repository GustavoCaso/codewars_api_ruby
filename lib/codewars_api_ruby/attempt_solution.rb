require 'codewars_api_ruby/object_builder'

module CodewarsApiRuby
  class AttemptSolution
    include ObjectBuilder

    def initialize(data:)
      binding.pry
      _build_object(data)
    end
  end
end
