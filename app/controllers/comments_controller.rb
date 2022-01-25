class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
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

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    respond_to do |format|
      format.html { redirect_to [:post], notice: 'Comment was successfully deleted.' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
