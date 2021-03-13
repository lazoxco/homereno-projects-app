class TasksController < ApplicationController

  def new
    if params[:project_id] && @project = Project.find_by_id(params[:project_id])
      @task = @project.tasks.build
    else
      @error = "That project doesn't exist." fi params[:project_id]
    end
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task
    else
      render :new
    end
  end

  def index
  end

  def show
    @task = Task.find_by_id(params[:id])
  end

  private

  def task_params
    params.require(:task).permit(:desciption)
  end
end
