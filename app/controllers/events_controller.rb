class EventsController < ApplicationController
  LIMIT = 10

  # 这里要说明一下，api 最好不写在这个位置，但是只有一个 api，就写在这里了
  # 另外输出 entity 也不应该写在 model 里，同样是方便起见，这里说明下
  def data
    @team = Team.find(params[:team_id])
    # 事实上 user 和 team 之间应当还有一层 access
    # 这样查询当 projects 多的时候可能会有性能问题
    @projects = @team.projects.where(id: current_user.projects.pluck(:id)).only(:id)
    @events = Event.where(project_id: @projects.pluck(:id))

    # 使用游标的方式分页
    if params[:till_id]
      @events = @events.where("id < ?", params[:till_id])
    end

    @events = @events.limit(LIMIT)

    render json: @events.map(&:to_hash)
  end
end
