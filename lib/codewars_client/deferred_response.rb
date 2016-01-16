require 'codewars_client/object_builder'

module CodewarsClient
  class DeferredResponse
    include ObjectBuilder
    PATH = 'deferred'

    def initialize(data:)
      _build_object(data)
    end
  end
end
