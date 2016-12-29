module APISupport
  extend ActiveSupport::Concern

  def prepare_data
    @user = create(:user)
    @team = create(:team)
    @project1 = create(:project, team: @team)
    @project2 = create(:project, team: @team)
    @access = Access.create(user: @user, project: @project1, role: 'admin')
    @todo1 = @project1.todos.create(name: '早上吃早饭')
    @todo2 = @project1.todos.create(name: '中午吃午饭', due_at: Time.now.to_i)
    @todo3 = @project1.todos.create(name: '晚上吃晚饭', is_complete: true)
    @todo4 = @project1.todos.create(name: '还要吃夜宵', assignee_id: @user.id)
  end

  def json
    JSON.parse(response.body)
  end
end
