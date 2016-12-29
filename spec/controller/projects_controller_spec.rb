require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  render_views
  describe '#show' do
    before do
      prepare_data
    end

    it 'should show todo list' do
      get :show, params: { id: @project1.id }

      expect(response).to be_success
      expect(response.body).to match(/任务/)
    end

    it 'should show index when user not have access' do
      get :show, params: { id: @project2.id }

      expect(response.status).to eq(302)
    end

    it 'should show message when no todos' do
      @project1.todos.destroy_all

      get :show, params: { id: @project1.id }
      expect(response).to be_success
      expect(response.body).to match(/还没有任务/)
    end

    it 'should show index when user not sign in' do
      @user.destroy

      get :show, params: { id: @project2.id }
      expect(response.status).to eq(302)
    end
  end
end
