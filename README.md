# CodewarsApiRuby

Simple Wrapper for the [Codewars]() site, where you can improve your coding skills by completing Katas.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codewars_api_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codewars_api_ruby
    
## Configuration
To use this gem you have to have an account with [Codewars]().
Then get the Api key from the profile settings and added to the gem.
There are to ways of configuration.

1- Block

```ruby
  CodewarsApiRuby.configure do |config|
	config.api_key = API_KEY
  end
```

2- Inline

`CodewarApiRuby.api_key = API_KEY`

## Endpoints

### User

`CodewarsApiRuby.user(username_or_id: USERNAME_OR_ID)`

It will return a `CodewarsApiRuby::User` object with all the information of the user.

### Next Kata

`CodewarsApiRuby.next_kata(language: LANGUAGE)`

#### Valid languages

```
clojure
coffescript
c
haskell
java
javascript
pythom
ruby
```

It will return a `CodewarsApiRuby::NextKata` object with all the information of the user and start a new training session for the kata.

### Attemp Solution

`CodewarsApiRuby.attempt_solution(kata: NEXT_KATA_OBJECT , code: YOUR_CODE)`

Will return 

    

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/codewars_api_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

