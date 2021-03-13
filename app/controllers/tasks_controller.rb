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
    # @task = Task.new(task_params)

    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to project_task_path(@task.project, @task)
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
