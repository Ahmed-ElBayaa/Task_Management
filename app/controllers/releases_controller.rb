class ReleasesController < ApplicationController
  
  load_and_authorize_resource
  # GET /releases/1
  # GET /releases/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @release }
    end
  end

  # GET /releases/new
  # GET /releases/new.json
  def new
    @release = Release.new
    @project_id = params[:project_id]
    
    if (@project_id)
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @release }
      end
    else
      redirect_to projects_path, notice: "can't create independent releases"
    end  
  end

  # GET /releases/1/edit
  def edit
    @project_id = @release.project_id
  end

  # POST /releases
  # POST /releases.json
  def create
    p_id = params[:release][:project_id]
    project = current_user.projects.find(p_id)
    @release = Release.new(params[:release])

    respond_to do |format|
      if @release.save
        format.html { redirect_to @release,
            notice: 'Release was successfully created.' }
        format.json { render json: @release, status: :created, location: @release }
      else
        @project_id = params[:release][:project_id]
        format.html { render action: "new" }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /releases/1
  # PUT /releases/1.json
  def update
    p_id = @release.project_id
    project = current_user.projects.find(p_id)

    respond_to do |format|
      if @release.update_attributes(params[:release])
        format.html { redirect_to @release,
            notice: 'Release was successfully updated.' }
        format.json { head :ok }
      else
        @project_id = @release.project_id
        format.html { render action: "edit" }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end
end
