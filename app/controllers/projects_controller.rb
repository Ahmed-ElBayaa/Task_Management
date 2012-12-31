class ProjectsController < ApplicationController
  load_and_authorize_resource find_by: :identifier

  # GET /projects
  # GET /projects.json
  def index
    if user_signed_in?
      @search = current_user.projects.search(params[:search])
    else
      @search = Project.search(params[:search])
    end

    @projects = @search.paginate per_page: 15, page: params[:page],
          order: "name"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new

    @project = Project.new
    @main_projects = Project.roots.where(creator_id: current_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @main_projects = Project.roots.where(creator_id: @project.creator_id)
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @project.creator_id = current_user.id	  
    respond_to do |format|
      if @project.save
        @project.users << current_user
        format.html { redirect_to project_path(@project), notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        @main_projects = Project.roots.where(creator_id: @project.creator_id)
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        @main_projects = Project.roots.where(creator_id: @project.creator_id)
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    # @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end

  # put /projects/:id/new_members
  # put //projects/:id/new_members.json
  def new_members
    @members = User.all
  end


  # put /projects/:id/create_members
  # put //projects/:id/create_members.json
  def create_members
    project = Project.find(params[:id])

    params[:members].each do |member_id|
      user = User.find(member_id)
      project.users << user unless project.users.include?(user)  
    end
    
    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: 'members were successfully added.' }
      format.json { render json: @project, status: :created, location: @project }
    end
  end

  def tasks
  end

end
