class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:create, :new]

  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo.project }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def show
    @comments = @todo.comments
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.project = @project

    if @todo.save
      redirect_to project_path(@project)
    else
      format.html { render action: 'new' }
    end
  end

  def new
    @todo = @project.todos.new
  end

  def destroy
    @todo.destroy
  end

  # 这里提及一下，因为需要记录是谁，在什么时候关闭了任务，应当有一个表记录相关信息, 用 event 表也可以
  # 另外测试中没有提到要做 reopen，所以我也略过了
  def complete
    @todo = Todo.find(params[:todo_id])
    return if @todo.is_complete == true
    @todo.update_attribute(:is_complete, true)
    # TODO:  增加 event 逻辑
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:name, :due_at, :assignee_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
