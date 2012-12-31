class TasksController < ApplicationController
  
  load_and_authorize_resource

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    @sprint_id = params[:sprint_id]
    @assignee_id = current_user.id
    if(@sprint_id)
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @task }
      end
    else
      redirect_to projects_path, notice: "can't create independent tasks"
    end
  end

  # GET /tasks/1/edit
  def edit
    @sprint_id = @task.sprint_id
    @assignee_id = @task.assignee_id
    redirect_to projects_path,notice:("can't edit independent tasks") unless @sprint_id
  end

  # POST /tasks
  # POST /tasks.json
  def create
    sprint = Sprint.find(params[:task][:sprint_id])
    project = current_user.projects.find(sprint.release.project_id)
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to sprint_path(@task.sprint_id), notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        @sprint_id = params[:task][:sprint_id]
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    sprint = Sprint.find(@task.sprint_id)
    project = current_user.projects.find(sprint.release.project_id)

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to sprint_path(@task.sprint_id), notice: 'Task was successfully updated.' }
        format.json { head :ok }
      else
        @sprint_id = @task.sprint_id
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
end
