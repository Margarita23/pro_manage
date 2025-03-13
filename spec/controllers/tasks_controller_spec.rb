require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }
  let(:task_params) { attributes_for(:task) }
  let(:invalid_params) { { task: { title: '' } } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a list of tasks for the project' do
      task
      get :index, params: { project_id: project.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an(Array)
      expect(JSON.parse(response.body).first['id']).to eq(task.id)
    end

    it 'filters tasks by status if status param is provided' do
      task.update(status: 'completed')
      get :index, params: { project_id: project.id, status: 'completed' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first['status']).to eq('completed')
    end
  end

  describe 'GET #show' do
    it 'returns the specified task' do
      get :show, params: { project_id: project.id, id: task.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(task.id)
    end

    it 'returns 404 if task not found' do
      get :show, params: { project_id: project.id, id: 999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['message']).to eq('Task not found')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new task' do
        expect {
          post :create, params: { project_id: project.id, task: task_params }
        }.to change(Task, :count).by(1)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['title']).to eq(task_params[:title])
      end
    end

    context 'with invalid params' do
      it 'does not create a task' do
        expect {
          post :create, params: { project_id: project.id, task: invalid_params[:task] }
        }.not_to change(Task, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the task' do
        put :update, params: { project_id: project.id, id: task.id, task: { title: 'Updated Title' } }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('task successfully updated')
      end
    end

    context 'with invalid params' do
      it 'does not update the task' do
        put :update, params: { project_id: project.id, id: task.id, task: { title: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('title')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the task' do
      task
      expect {
        delete :destroy, params: { project_id: project.id, id: task.id }
      }.to change(Task, :count).by(-1)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('task successfully deleted')
    end

    it 'returns 404 if task not found' do
      delete :destroy, params: { project_id: project.id, id: 999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['message']).to eq('Task not found')
    end
  end
end
