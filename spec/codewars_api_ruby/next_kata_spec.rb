require 'spec_helper'

describe CodewarsApiRuby::NextKata do
  let(:next_kata_payload) do
    {
     "success"=>true,
     "name"=>"Square into Squares. Protect trees!",
     "slug"=>"square-into-squares-protect-trees",
     "href"=>"/kata/square-into-squares-protect-trees",
     "description"=>
      "My little sister came back home from school with the following task:\ngiven a squared sheet of paper she has to cut it in pieces\nwhich, when assembled, give squares the sides of which form\nan increasing sequence of numbers.\nAt the beginning it was lot of fun but little by little we were tired of seeing the pile of torn paper.\nSo we decided to write a program that could help us and protects trees.\n\n## Task\n\nGiven a positive integral number n, return a **strictly increasing** sequence (list/array/string depending on the language) of numbers, so that the sum of the squares is equal to n².\n\nIf there are multiple solutions (and there will be), return the result with the largest possible values:\n\n## Examples\n\n`decompose(11)` must return `[1,2,4,10]`. Note that there are actually two ways to decompose 11²,\n11² = 121 = 1 + 4 + 16 + 100 = 1² + 2² + 4² + 10² but don't return `[2,6,9]`, since 9 is smaller than 10.\n\nFor `decompose(50)` don't return `[1, 1, 4, 9, 49]` but `[1, 3, 5, 8, 49]` since `[1, 1, 4, 9, 49]`\ndoesn't form a strictly increasing sequence.\n\n```haskell\ndecompose 50 `shouldBe` Just [1,3,5,8,49]\ndecompose 4  `shouldBe` Nothing\n```\n\n## Note\nNeither `[n]` nor `[1,1,1,…,1]` are valid solutions. If no valid solution exists, return `nil`, `null`, `Nothing`, `None` or `\"\"`.\n\nThe function \"decompose\" will take a positive integer n \nand return the decomposition of N = n² as:\n\n```ruby\n[x1 ... xk]\n```\n```javascript\n[x1 ... xk]\n```\n```coffeescript\n[x1 ... xk]\n```\n```java\n\"x1 ... xk\"\n```\n```csharp\n\"x1 ... xk\"\n```\n```python\n[x1 ... xk]\n```\n```haskell\nJust [x1 ... xk]\n```\n\n## Hint\n\nVery often `xk` will be `n-1`.\n",
     "author"=>"",
     "rank"=>-4,
     "averageCompletion"=>nil,
     "tags"=>["Fundamentals", "Mathematics", "Algorithms", "Logic", "Numbers", "Sequences", "Arrays", "Data Types"],
     "session"=>
      {"projectId"=>"56810a128b5faaf6cd000002",
       "solutionId"=>"56810a128b5faaf6cd000004",
       "setup"=>"def decompose(n)\n  # your code\nend",
       "exampleFixture"=>"\nTest.assert_equals(decompose(5), [3,4])",
       "code"=>nil}
     }
  end

  subject { described_class.new(data: JSON[next_kata_payload.to_json]) }
  it_should_behave_like 'next_kata_methods'
end
