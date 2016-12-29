class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :assignee, class_name: 'User'
  has_many :comments
  has_many :events, as: :eventable

  acts_as_paranoid

  def create_event(mode, user, json = {})
    self.events.create  mode: mode,
                        project_id: self.project_id,
                        user: user,
                        extra: {
                          title: self.name,
                        }.merge(json).to_json

  end
end
