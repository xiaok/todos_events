class TodoUpdateService
  def initialize(todo, todo_params, current_user)
    self.todo = todo
    self.todo_params = todo_params
    self.attributes_was = todo.attributes.dup
    self.current_user = current_user
  end

  def process
    begin
      update_todo!
      self.attributes_is = todo.attributes.dup

      add_update_assign_event if assign_changed?
      add_update_due_at_event if due_at_changed?
      true
    rescue
      false
    end
  end

  private

  attr_accessor :todo, :attributes_was, :attributes_is, :todo_params, :current_user

  def update_todo!
    todo.update!(todo_params)
  end

  def assign_changed?
    attributes_was['assignee_id'] != attributes_is['assignee_id']
  end

  def due_at_changed?
    attributes_was['due_at'] != attributes_is['due_at']
  end

  def add_update_assign_event
    todo.create_event(
      'todo.update_assign',
      current_user,
      from: attributes_was['assignee_id'] ? User.find_by(id: attributes_was['assignee_id']).name : nil,
      to: attributes_is['assignee_id'] ? User.find_by(id: attributes_is['assignee_id']).name : nil
    )
  end

  def add_update_due_at_event
    todo.create_event(
      'todo.update_due_at',
      current_user,
      from: attributes_was['due_at'] || '没有截止日期',
      to: attributes_is['due_at'] || '没有截止日期'
    )
  end
end
