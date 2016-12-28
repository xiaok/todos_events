FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    avatar_url { Faker::Avatar.image }
  end
end
