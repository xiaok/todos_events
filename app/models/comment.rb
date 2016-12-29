class Comment < ApplicationRecord
  belongs_to :todo
  belongs_to :user
  has_many :events, as: :eventable

  def create_event(mode)
    events.create   mode: mode,
                    project_id: todo.project_id,
                    user: user,
                    extra: {
                      title: todo.name,
                      content: content
                    }.to_json
  end
end
