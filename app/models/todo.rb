class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :assignee, class_name: 'User'
  has_many :comments
end
