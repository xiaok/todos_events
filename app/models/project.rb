class Project < ApplicationRecord
  has_many :users, through: :accesses
  has_many :todos
  belongs_to :team
end
