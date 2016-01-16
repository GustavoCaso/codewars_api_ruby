require 'spec_helper'

describe CodewarsClient::User do
  let(:user_params) do
    {
     "username"=>"GustavoCaso",
     "name"=>"",
     "honor"=>325,
     "clan"=>"L a Peña",
     "leaderboardPosition"=>1895,
     "skills"=>[],
     "ranks"=>
      {
       "overall"=>{"rank"=>-4, "name"=>"4 kyu", "color"=>"blue", "score"=>1708},
       "languages"=>
        {
          "ruby"=>{
            "rank"=>-4,
            "name"=>"4 kyu",
            "color"=>"blue",
            "score"=>1589
           },
         "javascript"=> {
           "rank"=>-6,
           "name"=>"6 kyu",
           "color"=>"yellow",
           "score"=>123
           },
         "coffeescript"=> {
          "rank"=>-8,
          "name"=>"8 kyu",
          "color"=>"white",
          "score"=>6
          }
        }
      },
     "codeChallenges"=>{"totalAuthored"=>0, "totalCompleted"=>121}
    }
  end

  subject {described_class.new(data: JSON[user_params.to_json])}
  it_should_behave_like 'user_methods'
end
