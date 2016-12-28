FactoryGirl.define do
  factory :team do
    sequence(:name) { |i| "team_#{i}" }
  end
end
