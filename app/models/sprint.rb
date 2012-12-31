class Sprint < ActiveRecord::Base
	has_many :tasks, dependent: :destroy
	belongs_to :release

	accepts_nested_attributes_for :tasks, allow_destroy: true

	attr_accessible :tasks_attributes, :start_date, :end_date, :release_id

	def project_members
		begin
			release.project.users
		rescue
			[]
		end
	end

end
