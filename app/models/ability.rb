class Ability
  include CanCan::Ability

  #def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  #end

  def initialize(user)
  	alias_action :update, :edit, :destroy, :show, to: :access
	alias_action :new_members, :create_members, to: :add_members
  	user ||= User.new # guest user (not logged in)

  	if user.admin?

  		can :create, [Project, Release, Sprint]

  		can :manage, User

  		can [:access, :add_members], Project do |project|		
		  project.creator_id == user.id
		end

		can :access, Release do |release|
			release.project.creator_id == user.id
		end

		can :access, Sprint do |sprint|
			sprint.release.project.creator_id == user.id
		end

		can :access, Task do |task|
			task.sprint.release.project.creator_id == user.id
		end

		can :access, Comment do |comment|
			comment.task.sprint.release.project.creator_id == user.id
		end

	end
		can :index, Project

		can [:show, :tasks], Project do |project|
			project.users.include?(user)
		end

		can :show, [Release, Sprint, Task] do |instance|
			instance.project_members.include?(user)
		end

		can :create, Task

		can [:update], Task do |task|
			task.assignee_id == user.id
		end

		can [:create], Comment

		# can [:update], Comment do |comment|
		# 	# todo: modify it to update only own comments
		# 	comment.task.sprint.release.project.users.include?(user)
		# end

  end
end
