require 'json'
module CodewarsApiRuby
  class User
    PATH = 'users'

    def initialize(data:)
      @user_data = JSON.parse(data)
      build_user
    end

    def build_user
      @user_data.each do |key, value|
        build_attr_reader(key)
        set_attr_value(key, value)
      end
    end

    def build_attr_reader(key)
      self.class.class_eval("attr_reader :#{key}")
    end

    def set_attr_value(key, value)
      instance_variable_set("@#{key}", value)
    end
  end
end
