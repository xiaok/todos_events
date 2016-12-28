class Project < ApplicationRecord
  has_many :users, through: :accesses
  belongs_to :team
end
