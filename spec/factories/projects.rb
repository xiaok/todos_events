FactoryGirl.define do
  factory :project do
    sequence(:name) { |i| "project_#{i}" }
    team
  end
end
