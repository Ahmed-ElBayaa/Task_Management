class SprintsController < ApplicationController
  
  load_and_authorize_resource

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sprint }
    end
  end

  # GET /sprints/new
  # GET /sprints/new.json
  def new
    @sprint = Sprint.new
    @release_id = params[:release_id]
    if(@release_id)
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @sprint }
      end
    else
      redirect_to projects_path,
        notice: "can't create independent sprints"
    end
  end

  # GET /sprints/1/edit
  def edit
    @release_id = @sprint.release_id
    redirect_to projects_path,
      notice:("can't edit independent sprints") unless @release_id
  end

  # POST /sprints
  # POST /sprints.json
  def create
    release = Release.find(params[:sprint][:release_id])
    project = current_user.projects.find(release.project_id)
    @sprint = Sprint.new(params[:sprint])

    respond_to do |format|
      if @sprint.save
        format.html { redirect_to release_path(@sprint.release_id), notice: 'Sprint was successfully created.' }
        format.json { render json: @sprint, status: :created, location: @sprint }
      else
        @release_id = params[:sprint][:release_id]
        format.html { render action: "new" }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sprints/1
  # PUT /sprints/1.json
  def update
    release = Release.find(@sprint.release_id)
    project = current_user.projects.find(release.project_id)

    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        format.html { redirect_to release_path(@sprint.release_id), notice: 'Sprint was successfully updated.' }
        format.json { head :ok }
      else
        @release_id = @sprint.release_id
        format.html { render action: "edit" }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end
end
