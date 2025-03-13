class Api::V1::ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_project, only: [:show, :update, :destroy]

	def index
		@projects = current_user.projects
		
		render json: @projects
	end

	def show
		render json: @project
	end

	def create
		@project = current_user.projects.build(project_params)
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
	end

	def update
		if @project.update(project_params)
			render json: { message: "Project successfully updated" }
		else
			render json: @project.errors, status: :unprocessable_entity
		end
	end

	def destroy
		if @project
			@project.destroy
			render json: { message: "Project successfully deleted" }
		else
			render json: { message: "Unable to delete project" }
		end
	end

	private

	def set_project
    @project = current_user.projects.find_by(id: params[:id])
    render json: { error: 'Project not found' }, status: :not_found if @project.nil?
  end

	def project_params
		params.require(:project).permit(:title, :description)
	end

	def find_project
		@project = current_user.projects.find(params[:id])
	end

end
