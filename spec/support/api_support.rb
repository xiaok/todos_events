module APISupport
  extend ActiveSupport::Concern

  def prepare_data
    @user = User.create(name: 'yixin', avatar_url: Faker::Avatar.image)
    @team = Team.create(name: 'team')
    @project1 = @team.projects.create(name: 'project1')
    @project2 = @team.projects.create(name: 'project2')
    @access = Access.create(user: @user, project: @project1, role: 'admin')
    @todo1 = @project1.todos.create(name: '早上吃早饭')
    @todo2 = @project1.todos.create(name: '中午吃午饭', due_at: Time.now.to_i)
    @todo3 = @project1.todos.create(name: '晚上吃晚饭', is_complete: true)
    @todo4 = @project1.todos.create(name: '还要吃夜宵', assignee_id: @user.id)
  end
end
