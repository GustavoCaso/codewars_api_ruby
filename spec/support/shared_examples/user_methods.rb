shared_examples 'user_methods' do
  context 'user methods' do
    [:username, :name, :honor, :clan,
     :leaderboard_position,:skills,
     :overall, :languages, :total_authored,
     :total_completed].each do |key|
      it "respond_to #{key}" do
        expect(subject.respond_to?(key)).to be_truthy
      end
    end
  end
end
