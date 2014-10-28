FactoryGirl.define do
  factory :team do
    team_name {Faker::Name.name}
    association :user

    after(:create) do |team|
      team.user_teams << FactoryGirl.build(:user_team, team_id: team.id)
    end
  end
end