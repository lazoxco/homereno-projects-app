class CommentsController < ApplicationController
  def new
    if params[:project_id] && @project = Project.find_by_id(params[:project_id])
      @comment = @project.comments.build
    else
      @error = "That project doesn't exist." if params[:project_id]
      @comment = Comment.new
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to project_comment_path(@comment.project, @comment)
    else
      render :new
    end
  end

  def index
    if params[:project_id] && @project = Project.find_by_id(params[:project_id])
      @comments = @project.comments
    else
      @error = "That project doesn't exist." if params[:project_id]
      @comments = Comment.all
    end
  end

  def show
    @comment = Comment.find_by_id(params[:id])
    redirect_to comments_path if !@comment
  end

  def edit
    @comment = Comment.find_by_id(params[:id])
  end

  def update
    @comment = Comment.find_by(params[:id])
    if @comment.update(comment_params)
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :project_id)
  end
end
