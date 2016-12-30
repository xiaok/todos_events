require 'rails_helper'

RSpec.describe TodoUpdateService do
  before(:each) do
    @user = create(:user)
    @user2 = create(:user)
    @team = create(:team)
    @project = create(:project, team: @team)
    @access = Access.create(user: @user, project: @project1, role: 'admin')
    @todo = @project.todos.create(name: '早上吃早饭')
  end

  describe 'update assign column' do
    context 'from null to user' do
      it "should create update_assign event" do
        TodoUpdateService.new(@todo, { assignee_id: @user.id }, @user).process
        event = Event.last
        expect(event.mode).to eq 'todo.update_assign'
      end
    end

    context 'from user to another user' do
      it "should create update_assign event" do
        @todo.update(assignee_id: @user.id)
        TodoUpdateService.new(@todo, { assignee_id: @user2.id }, @user).process

        event = Event.last
        expect(event.mode).to eq 'todo.update_assign'
      end
    end

    context 'from user to null' do
      it "should create update_assign event" do
        @todo.update(assignee_id: @user.id)
        TodoUpdateService.new(@todo, { assignee_id: nil }, @user).process

        event = Event.last
        expect(event.mode).to eq 'todo.update_assign'
      end
    end

    context 'from null to due_at' do
      it "should create update_assign event" do
        TodoUpdateService.new(@todo, { due_at: Time.now }, @user).process

        event = Event.last
        expect(event.mode).to eq 'todo.update_due_at'
      end
    end

    context 'from due_at to another due_at' do
      it "should create update_assign event" do
        @todo.update(due_at: Time.now.to_i)
        TodoUpdateService.new(@todo, { due_at: Time.now + 1.week }, @user).process

        event = Event.last
        expect(event.mode).to eq 'todo.update_due_at'
      end
    end

    context 'from due_at to null' do
      it "should create update_assign event" do
        @todo.update(due_at: Time.now)
        TodoUpdateService.new(@todo, { due_at: nil }, @user).process

        event = Event.last
        expect(event.mode).to eq 'todo.update_due_at'
      end
    end
  end
end
