class TodoList < ApplicationRecord
  belongs_to :project
  has_many :todos
end
