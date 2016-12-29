class Event < ApplicationRecord
  default_scope -> { order("created_at desc") }
  belongs_to :user
  belongs_to :project
  belongs_to :eventable, polymorphic: true

  def eventable
    eventable_type.constantize.unscoped { super }
  end

  # 这里应该存 json，使用的是 sqlite 不支持，所以这里转换一下
  def extra_json
    JSON.parse(extra)
  end
end
