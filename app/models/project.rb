class Project < ApplicationRecord
  has_many :users, through: :accesses
  has_many :todo_lists
  belongs_to :team
end
