class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: post.id)
    if @like.save
      @like.update_likes_counter
      flash[:notice] = 'Your like has been registered.'
      redirect_to [post]
    else
      flash[:notice] = 'Something went wrong with liking this post. :('
      redirect_to post
    end
  end
end
