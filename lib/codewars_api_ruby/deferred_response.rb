require 'codewars_api_ruby/object_builder'

module CodewarsApiRuby
  class DeferredResponse
    include ObjectBuilder
    PATH = 'deferred'

    def initialize(data:)
      _build_object(data)
    end
  end
end
