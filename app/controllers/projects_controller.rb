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

  def show
    @project = Project.find_by_id(params[:id])
    redirect_to projects_path if !@project
  end

  def edit
    @project = Project.find_by(params[:id])
  end

  def update
    @project = Project.find_by(params[:id])
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])    
    @project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :content)
  end
end
