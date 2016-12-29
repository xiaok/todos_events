class User < ApplicationRecord
  has_many :accesses
  has_many :projects, through: :accesses
  has_many :events
end
