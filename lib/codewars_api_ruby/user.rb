require 'codewars_api_ruby/object_builder'

module CodewarsApiRuby
  class User
    include ObjectBuilder
    PATH = 'users'

    def initialize(data:)
      _build_object(data)
      _build_language_methods
    end

    private

    def _build_language_methods
      languages.each do |key, value|
        _build_attr_reader(key)
        _build_language_content(key, value)
      end
    end

    def _build_language_content(key, value)
      instance_variable_set("@#{key}", OpenStruct.new(value))
    end
  end
end
