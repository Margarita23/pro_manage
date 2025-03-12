class Task < ApplicationRecord
  belongs_to :project

  validates :title, presence: true
  validates :status, inclusion: { in: ['created', 'in_progress', 'completed'] }

  enum :status, { created: 0, in_progress: 1, completed: 2 }, default: :created

  scope :by_status, ->(status) { where(status: status) }
  scope :by_project, ->(project_id) { where(project_id: project_id) }
end
