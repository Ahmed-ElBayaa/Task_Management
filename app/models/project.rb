class Project < ActiveRecord::Base

	has_ancestry

	 before_save :set_identifier 

	validates :name, uniqueness: :true
	validate :depth_must_be_at_most_one
	validate :parent_project
	

	has_and_belongs_to_many :users
	has_many :releases, dependent: :destroy

	accepts_nested_attributes_for :users
	
	accepts_nested_attributes_for :releases, allow_destroy: true

	attr_accessible :releases_attributes, :name, :start_date, :end_date,
			:parent_id
	
	def depth_must_be_at_most_one
		errors.add(:base," can't create subproject of subproject") if depth > 1
	end

	def parent_project
		if parent and parent.creator_id != self.creator_id
			errors.add(:base," can't create subproject of non-owned project")
		end
	end

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.name.parameterize
	end


end
