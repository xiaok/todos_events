class TodosController < ApplicationController
  before_action :set_todo, only: [:show]
  def show
    @comments = @todo.comments
  end

  # 这里提及一下，因为需要记录是谁，在什么时候关闭了任务，应当有一个表记录相关信息, 用 event 表也可以
  # 另外测试中没有提到要做 reopen，所以我也略过了
  def complete
    @todo = Todo.find(params[:todo_id])
    @todo.update_attribute(:is_complete, true)
    # TODO:  增加 event 逻辑
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
