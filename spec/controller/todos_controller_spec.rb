require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  describe '#complete' do
    before do
      prepare_data

      xhr :post, :complete, params: { todo_id: @todo1.id }
    end

    it "should mark the todo completed" do
      expect(@todo1.reload.is_complete).to eq true
    end
  end

  describe '#show' do
    render_views
    before do
      prepare_data
    end

    it "show todo detail" do
      get :show, params: { id: @todo1.id }
      expect(response).to be_success
      expect(response.body).to match(/#{@todo1.name}/)
    end

    it "show message when no comment" do
      get :show, params: { id: @todo1.id }
      expect(response.body).to match(/还没有评论/)
    end

    it "show comments" do
      comment = @todo1.comments.create(user: @user, content: '测试')
      get :show, params: { id: @todo1.id }
      expect(response.body).to match(/#{comment.content}/)
    end
  end

  describe 'update' do
    before do
      prepare_data
    end

    it "should update todos attributes" do
      patch :update, params: { project_id: @todo1.project.id, id: @todo1.id, todo: { name: '修改后的name' } }
      expect(@todo1.reload.name).to eq '修改后的name'
    end

    it "should not update project_id" do
      patch :update, params: { project_id: @todo1.project.id, id: @todo1.id, todo: { project_id: 2 } }
      expect(response).not_to be_success
    end
  end

  describe 'destroy' do
    before do
      prepare_data
    end

    it "should destroy todo" do
      xhr :delete, :destroy, params: { id: @todo1.id }

      expect(response).to be_success
      expect(Todo.find_by(id: @todo1.id)).to be_nil
    end
  end
end
