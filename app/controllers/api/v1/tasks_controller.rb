class Api::V1::TasksController < ApplicationController
	before_action :authenticate_user!
	before_action :find_project
	before_action :find_task, only: [:show, :update, :destroy]

	def index
		@tasks = filter_tasks

		render json: @tasks
	end

	def show
		render json: @task
	end

	def create
		@task = @project.tasks.build(task_params)
		if @task.save
			render json: @task
		else
			render json: @task.errors, status: :unprocessable_entity
		end
	end

	def update
		if @task.update(task_params)
			render json: { message: "task successfully updated" }
		else
			render json: @task.errors, status: :unprocessable_entity
		end
	end

	def destroy
		if @task
			@task.destroy
			render json: { message: "task successfully deleted" }
		else
			render json: { message: "Unable to delete task" }
		end
	end

	private

	def task_params
		params.require(:task).permit(:title, :description, :status, :project_id)
	end

	def find_task
		@task = @project.tasks.find_by(id: params[:id])
		render json: { message: "Task not found" }, status: :not_found if @task.nil?
	end

	def find_project
		@project = Project.find_by(id: params[:project_id])
		render json: { message: "Project not found" }, status: :not_found if @project.nil?
	end

	def filter_tasks
		tasks = @project.tasks
		tasks = tasks.by_status(params[:status]) if params[:status].present?
		tasks
	end
	
end
