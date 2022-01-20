class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    current_user = post.user
    @comment = current_user.comments.new(comment_params.merge(post_id: post.id))
    if @comment.save
      @comment.update_comments_counter
      flash[:notice] = 'Your comment has been created.'
      redirect_to [post]
    else
      flash[:alert] = 'We failed to create your comment, please make sure all fields are properly filled'
      redirect_to post
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
