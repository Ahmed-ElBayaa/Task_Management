class Task < ActiveRecord::Base

	AVAILABLE_STATUS = %w( defined inprogress completed accepted rejected )
	
	has_many :comments, dependent: :destroy
	belongs_to :sprint
	belongs_to :user

	validates_inclusion_of :status, in: %w( defined inprogress completed accepted rejected ), message: ':the task must be on one of "defined, inprogress, completed, accepted and rejected" statuses'
	accepts_nested_attributes_for :comments, allow_destroy: true

	attr_accessible :comments_attributes, :subject, :description, :status, :sprint_id, :assignee_id, :attachment

	has_attached_file :attachment

	def project_members
		begin
			sprint.release.project.users
		rescue
			[]
		end
	end

end
