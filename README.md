![Travis Master](https://travis-ci.org/GustavoCaso/codewars_client.svg?branch=master)
# CodewarsClient

Simple Wrapper for the [Codewars](http://www.codewars.com/) site, where you can improve your coding skills by completing Katas.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codewars_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codewars_client

## Configuration
To use this gem you have to have an account with [Codewars](http://www.codewars.com/).

Then get the Api key from the profile settings and added to the gem.

There are to ways of configuration.

1- Block

```ruby
  CodewarsClient.configure do |config|
	  config.api_key = API_KEY
  end
```

2- Inline

```ruby
CodewarsClient.api_key = API_KEY
```

## Endpoints

### User

```ruby
CodewarsClient.user(username_or_id: USERNAME_OR_ID)
```

It will return a `CodewarsClient::User` object with all the information of the user.

```json
{
    "username": "some_user",
    "name": "Some Person",
    "honor": 544,
    "clan": "some clan",
    "leaderboardPosition": 134,
    "skills": [
        "ruby",
        "c#",
        ".net",
        "javascript",
        "coffeescript",
        "nodejs",
        "rails"
    ],
    "ranks": {
        "overall": {
            "rank": -3,
            "name": "3 kyu",
            "color": "blue",
            "score": 2116
        },
        "languages": {
            "javascript": {
                "rank": -3,
                "name": "3 kyu",
                "color": "blue",
                "score": 1819
            },
            "ruby": {
                "rank": -4,
                "name": "4 kyu",
                "color": "blue",
                "score": 1005
            },
            "coffeescript": {
                "rank": -4,
                "name": "4 kyu",
                "color": "blue",
                "score": 870
            }
        }
    },
    "codeChallenges": {
        "totalAuthored": 3,
        "totalCompleted": 230
    }
}

```

### Next Kata

```ruby
CodewarsClient.next_kata(language: LANGUAGE)
```

#### Valid languages

```
clojure
coffescript
c
haskell
java
javascript
python
ruby
```

It accept language as `symbol` and `string`

It will return a `CodewarsClient::NextKata` object with all the information of the kata and start a new training session.

```json
{
   "success":true,
   "name":"Anything to integer",
   "slug":"anything-to-integer",
   "description":"Your task is to program a function which converts any input to an integer.\n\nDo not perform rounding, the fractional part should simply be discarded.\n\nIf converting the input to an integer does not make sense (with an object, for instance), the function should return 0 (zero).\n\nAlso, Math.floor(), parseInt() and parseFloat() are disabled for your unconvenience.\n\nOnegaishimasu!",
   "author":"Jake Hoffner",
   "rank":-6,
   "averageCompletion":125.4,
   "tags":[
      "Fundamentals",
      "Integers",
      "Data Types",
      "Numbers"
   ],
   "session":{
       "projectId":"523f66fba0de5d94410001cb",
       "solutionId":"53bc968d35fd2feefd000013",
       "setup":"function toInteger(n) {\n  \n}",
       "exampleFixture":"Test.expect(toInteger(\"4.55\") === 4)",
       "code":null
   }
}
```

### Attemp Solution

```ruby
CodewarsClient.attempt_solution(kata: NEXT_KATA_OBJECT , code: YOUR_CODE)
```

The `NEXT_KATA_OBJECT` could be any kind of object at least it has te respond to `solution_id` and `project_id` and return valid data related with the kata.

Will submit a solution to be validated, this will return a deferred message id (dmid) which will be use to poll for the response.

```json
{
   "success":true,
   "dmid":"4rsdaDf8d"
}
```

### Deferred Response

```ruby
CodewarsClient.deferred_response(dmid: DMID)
```

This is use for polling the response from the server. It will return a `CodewarsClient::DeferredResponse` object with al the information.

```json
{
   "success":true,
   "dmid":"4rsdaDf8d",
   "valid": false,
   "reason":"-e: Value is not what was expected (Test::Error)\n",
   "output":[
      "<div class='console-failed'>Value is not what was expected</div>"
   ],
   "wall_time":45
}
```

### Finalize Solution

```ruby
CodewarsClient.finalize(kata: NEXT_KATA_OBJECT)
```

The `NEXT_KATA_OBJECT` could be any kind of object at least it has te respond to `solution_id` and `project_id` and return valid data related with the kata.

This endpoint is used to finalize the previously submitted solution. This endpoint will only return a success message if there has been a previously successful solution.

```json
{
   "success":true
}
```

## Practical Example

```ruby
CodewarsClient.api_key = 'fake_api_key'

def client
  CodewarsClient
end

kata = client.next_kata(language: :ruby)

# Read the kata information and complete it with some code !!!

code = File.read('./solution.rb')

attempt_solution = client.attempt_solution(kata: kata, code: code)

10.times do
  deferred_response = client.deferred_response(dmid: attempt_solution.dmid)
  break if deferred_response.success
end

if deferred_response.valid
  client.finalize_solution(kata: kata)
else
  warn deferred_response.reason
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To been able to run the test or to use the api with the interactive prompt you will have to create a `secrest.yml` file inside the `config` folder and store a valid api_key. `api_key: VALID_API_KEY`

Then, run `rake spec` to run the tests. Run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/GustavoCaso/codewars_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

