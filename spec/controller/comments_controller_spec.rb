require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe '#create' do
    before do
      prepare_data
    end

    it "should create comments" do
      xhr :patch, :create, params: { todo_id: @todo1.id, comment: { content: 'test' } }

      expect(response).to be_success

      comment = Comment.last

      expect(comment.todo_id).to eq @todo1.id
      expect(comment.content).to eq 'test'
      expect(comment.user.id).to eq @user.id
    end
  end
end
