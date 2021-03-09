class ProjectsController < ApplicationController
  
  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def index
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
      @projects = @user.projects
    else
      @error = "That user doesn't exist" if params[:user_id]
      @projects = Project.all
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :content)
  end
end
