class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    current_user = User.find(params[:user_id])
    @post = current_user.posts.new(post_params.merge(user_id: current_user.id))
    if @post.save
      redirect_to [@post.user, @post]
    else
      redirect_to [:new_user_post]
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
