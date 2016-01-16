require 'codewars_client/object_builder'

module CodewarsClient
  class NextKata
    include ObjectBuilder
    PATH = 'code-challenges'

    def initialize(data:)
      _build_object(data)
    end
  end
end
