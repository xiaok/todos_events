class Todo < ApplicationRecord
  belongs_to :todo_list
  belongs_to :assignee, class_name: 'User'
end
