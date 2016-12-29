require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  render_views
  describe '#data' do
    before(:each) do
      prepare_data
    end

    it 'get event list' do
      @todo1.create_event('todo.create', @user)
      xhr :get, :data, params: { team_id: @team.id }
      expect(response).to be_success
      expect(json.size).to eq 1

      event = json[0]

      expect(event['mode']).to eq 'todo.create'
    end

    describe 'paginate' do
      it 'get LIMIT list' do
        20.times { @todo1.create_event('todo.create', @user) }
        xhr :get, :data, params: { team_id: @team.id }
        expect(response).to be_success
        expect(json.size).to eq 10
      end

      it "should get list by till_id" do
        15.times { @todo1.create_event('todo.create', @user) }
        xhr :get, :data, params: { team_id: @team.id }
        expect(json.size).to eq 10

        till_id = json.last['id']

        xhr :get, :data, params: { team_id: @team.id, till_id: till_id }
        expect(response).to be_success
        expect(json.size).to eq 5
      end

      it "should get [] when over ranged" do
        9.times { @todo1.create_event('todo.create', @user) }
        xhr :get, :data, params: { team_id: @team.id }
        expect(json.size).to eq 9

        till_id = json.last['id']

        xhr :get, :data, params: { team_id: @team.id, till_id: till_id }
        expect(response).to be_success
        expect(json.size).to eq 0
      end
    end
  end
end
