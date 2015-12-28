require 'json'
module CodewarsApiRuby
  class User
    PATH = 'users'

    def initialize(data:)
      user_data = JSON.parse(data)
      _build_user(user_data)
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

    def _build_user(data)
      data.each do |key, value|
        if value.is_a? Hash
          _build_methods(value)
        else
          _mount_values_and_methods(key, value)
        end
      end
    end

    def _build_methods(values)
      values.each do |key, value|
        _mount_values_and_methods(key, value)
      end
    end

    def _mount_values_and_methods(key, value)
      new_key = _underscore_key(key)
      _build_attr_reader(new_key)
      _set_attr_value(new_key, value)
    end

    def _build_attr_reader(key)
      self.class.instance_eval("attr_reader :#{key}")
    end

    def _set_attr_value(key, value)
      instance_variable_set("@#{key}", value)
    end

    def _underscore_key(key)
      match = key.match(/^([a-z]*)([A-Z].*)/)
      return key unless match
      "#{match[1]}_#{match[2].downcase}"
    end
  end
end
