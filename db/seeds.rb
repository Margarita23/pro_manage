# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user_1 = User.create(email: "user@example.com", password: "12345678", password_confirmation: "12345678")

project_1 = Project.create(title: "Landing Photo", description: "A project for landing page photo", user_id: user_1.id)
project_2 = Project.create(title: "Landing Video", description: "A project for landing page video", user_id: user_1.id)
project_3 = Project.create(title: "Landing Animation", description: "A project for landing page animation", user_id: user_1.id)

task_1 = Task.create(title: "Create Photo", description: "Create photo for landing page", status: :created, project_id: project_1.id)
task_2 = Task.create(title: "Edit Photo", description: "Edit photo for landing page", status: :in_progress, project_id: project_1.id)
task_3 = Task.create(title: "Approve Photo", description: "Approve photo for landing page", status: :completed, project_id: project_1.id)

task_4 = Task.create(title: "Create Video", description: "Create video for landing page", status: :created, project_id: project_2.id)
task_5 = Task.create(title: "Edit Video", description: "Edit video for landing page", status: :in_progress, project_id: project_2.id)
task_6 = Task.create(title: "Approve Video", description: "Approve video for landing page", status: :completed, project_id: project_2.id)

task_7 = Task.create(title: "Edit Animation", description: "Edit animation for landing page", status: :in_progress, project_id: project_3.id)
task_8 = Task.create(title: "Approve Animation", description: "Approve animation for landing page", status: :completed, project_id: project_3.id)
task_9 = Task.create(title: "Create Animation", description: "Create animation for landing page", status: :created, project_id: project_3.id)
