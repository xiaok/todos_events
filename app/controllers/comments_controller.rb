class CommentsController < ApplicationController
  def create
    @todo = Todo.find(params[:todo_id])
    @comment = @todo.comments.new comment_params
    @comment.user = current_user
    @comment.save

    @comment.create_event('comment.create')
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
