class TasksController < ApplicationController

  def require_permission
    if current_user == @project.user
      @task = @project.tasks.build
    else
      @error = "Permission denied."
      redirect_to projects_path
    end
  end

  def new
    redirect_if_not_logged_in
    if params[:project_id] && @project = Project.find_by_id(params[:project_id])
      require_permission
    else
      @error = "That project doesn't exist." if params[:project_id]
      @task = Task.new
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to project_path(@task.project)
    else
      render :new
    end
  end

  def index
    if params[:project_id] && @project = Project.find_by_id(params[:project_id])
        @tasks = @project.tasks
    else
      @error = "That project doesn't exist." if params[:project_id]
      @tasks = Task.all
    end
  end

  def show
    @task = Task.find_by_id(params[:id])
    redirect_to tasks_path if !@task
  end

  def edit
    redirect_if_not_logged_in
    if params[:project_id] && @project = Project.find_by_id(params[:project_id])
      require_permission
    else
      @error = "That project doesn't exist." if params[:project_id]
      @task = Task.new
    end
  end

  def update
    @task = Task.find_by(params[:id])
    if @task.update(task_params)
      redirect_to project_path(@task.project)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:description, :project_id)
  end
end
