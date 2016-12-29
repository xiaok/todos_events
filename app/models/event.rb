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

  def action
    case mode
    when 'todo.create'
      '创建了任务'
    when 'todo.destroy'
      '删除了任务'
    when 'todo.complete'
      '完成了任务'
    when 'todo.update_assign'
      if extra_json['to'].blank?
        "取消了 #{extra_json['from']} 的任务"
      else
        "给 #{extra_json['to']} 指派了任务"
      end
    when 'todo.update_due_at'
      "将任务完成时间从 #{extra_json['from']} 修改为 #{extra_json['to']} "
    when 'comment.create'
      "回复了任务"
    end
  end


  def to_hash
    {
      id: id,
      action: action,
      eventable_type: eventable_type,
      eventable_id: eventable_id,
      extra: extra_json,
      mode: mode,
      user: {
        id: user.id,
        name: user.name,
        avatar_url: user.avatar_url
      },
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
