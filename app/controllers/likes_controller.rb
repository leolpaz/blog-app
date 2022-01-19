class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user = post.user
    @like = current_user.likes.new(post_id: post.id)
    if @like.save
      @like.update_likes_counter
      redirect_to [post]
    else
      redirect_to post
    end
  end
end
