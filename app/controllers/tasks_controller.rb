class TasksController < ApplicationController

  def new
    if params[:project_id] && @project = Project.find_by_id(params[:project_id])
      @task = @project.tasks.build
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
  end

  private

  def task_params
    params.require(:task).permit(:description, :project_id)
  end
end
