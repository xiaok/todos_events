FactoryGirl.define do
  factory :todo_list do
    sequence(:name) { |i| "todo_list_#{i}" }
  end
end
