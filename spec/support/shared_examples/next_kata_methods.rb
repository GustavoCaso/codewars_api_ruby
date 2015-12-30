shared_examples 'next_kata_methods' do
  context 'next_kata methods' do
    [:success, :name, :slug, :href,
     :description,:author,
     :rank, :average_completion, :tags,
     :project_id, :solution_id, :setup,
     :example_fixture, :code ].each do |key|
      it "respond_to #{key}" do
        expect(subject.respond_to?(key)).to be_truthy
      end
    end
  end
end
