class Comment < ApplicationRecord
  belongs_to :todo, required: true
  belongs_to :user, required: true
  has_many :events, as: :eventable

  validates :content, presence: true

  def create_event(mode)
    events.create   mode: mode,
                    project_id: todo.project_id,
                    user: user,
                    extra: {
                      title: todo.name,
                      content: content,
                      todo_id: todo.id
                    }.to_json
  end
end
