class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  before_action :require_user

  def auth!(project)
    access = current_user.projects.find_by(id: project.id)
    return redirect_to '/' unless access
  end

  private

  # 登入登出注册在测试中不重要，这里写死了一个 user
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.first
  end

  def require_user
    return redirect_to '/' unless current_user
  end
end
