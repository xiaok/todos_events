class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  before_action :require_user

  private
  # 登入登出注册在测试中不重要，这里写死了一个 user
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.first
  end

  def require_user
    unless current_user
      return redirect_to '/'
    end
  end
end
