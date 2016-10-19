class CommentsController < ApplicationController
  before_action :require_sign_in

  before_action :authorize_user, only: [:destroy]


  def create
    # change next line to lookup post or topic HINT: you can use params[:topic_id]

    if params[:post_id]
      @commentable = Post.find(params[:post_id])
    else
      @commentable = Topic.find(params[:topic_id])
    end

    @comment = @commentable.comments.new(comment_params)
    @comment = @commentable.user = current_user

    if @comment.save
      flash[:notice] = "Comment saved successfully."
      # if this is a topic, does topic.topic make sense?
      redirect_to [@commentable.topic, @post]
      # redirect to the topic
    else
      flash[:alert] = "Comment failed to save."
      redirect_to [@commentable.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted successfully."
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to [@post.topic, @post]
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end
end
