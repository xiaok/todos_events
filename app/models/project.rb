class Project < ApplicationRecord
  has_many :accesses
  has_many :users, through: :accesses
  has_many :todos
  belongs_to :team, required: true
  has_many :events

  validates :name, presence: true
end
