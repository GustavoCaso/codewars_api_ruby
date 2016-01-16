require 'codewars_client/object_builder'

module CodewarsClient
  class AttemptSolution
    include ObjectBuilder

    def initialize(data:)
      _build_object(data)
    end
  end
end
