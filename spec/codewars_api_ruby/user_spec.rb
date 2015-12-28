require 'spec_helper'

describe CodewarsApiRuby::User do
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

  let(:user) {described_class.new(data: user_params.to_json)}

  context 'build user methods and values' do
    [:username, :name, :honor, :clan,
     :leaderboard_position,:skills,
     :overall, :languages, :total_authored,
     :total_completed].each do |key|
      it "respond_to #{key}" do
        expect(user.respond_to?(key)).to be_truthy
      end

      it 'access all languages implemeted' do
        user.languages.
        expect()
      end
    end
  end
end
