class ProjectsController < ApplicationController
  before_action :set_project
  def show
    auth!(@project)
    @todos = @project.todos
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end
end
