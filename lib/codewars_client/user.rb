require 'codewars_client/object_builder'

module CodewarsClient
  class User
    include ObjectBuilder
    PATH = 'users'

    def initialize(data:)
      _build_object(data)
    end
  end
end
