require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do
	include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:project_params) { attributes_for(:project) }
  let(:invalid_params) { { project: { title: '' } } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a list of projects' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an(Array)
    end
  end

  describe 'GET #show' do
    it 'returns the specified project' do
      get :show, params: { id: project.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(project.id)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new project' do
        expect {
          post :create, params: { project: project_params }
        }.to change(Project, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a project' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Project, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the project' do
        put :update, params: { id: project.id, project: { title: 'Updated Title' } }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Project successfully updated')
      end
    end

    context 'with invalid params' do
      it 'does not update the project' do
        put :update, params: { id: project.id, project: { title: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the project' do
      project
      expect {
        delete :destroy, params: { id: project.id }
      }.to change(Project, :count).by(-1)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Project successfully deleted')
    end
  end
end
