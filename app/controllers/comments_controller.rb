class CommentsController < ApplicationController
  
  load_and_authorize_resource
  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
    @task_id = params[:task_id]
    if(@task_id)
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @comment }
      end
    else
      redirect_to projects_path, notice: "can't create independent comments"
    end
  end

  # GET /comments/1/edit
  def edit
    @task_id = @comment.task_id
    redirect_to projects_path,
          notice: ("can't edit independent comments") unless @task_id
  end

  # POST /comments
  # POST /comments.json
  def create
    # check if the task belongs to a project the user can comment on
    task = Task.find(params[:comment][:task_id])
    project = current_user.projects.find(task.sprint.release.project_id)

    #if no ActiveRecordNotFound Error then okay
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to task_path(@comment.task_id), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        @task_id = params[:comment][:task_id]
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    # check if the task belongs to a project the user can comment on
    task = Task.find(params[:comment][:task_id])
    project = current_user.projects.find(task.sprint.release.project_id)
    #if no ActiveRecordNotFound Error then okay

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to task_path(@comment.task_id), notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        @task_id = @comment.task_id
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
end
