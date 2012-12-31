class Release < ActiveRecord::Base
	has_many :sprints, dependent: :destroy
	belongs_to :project

	accepts_nested_attributes_for :sprints, allow_destroy: true

	attr_accessible :sprints_attributes, :version, :start_date, :end_date, :project_id

	def project_members
		begin
			project.users
		rescue
			[]
		end
	end
end
