FactoryGirl.define do
  factory :user_team do
    association :user
    association :team
    t_shirt_number {Faker::Number.number(2)}
    nickname {Faker::Name.name}
  end
end