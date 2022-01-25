class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).limit(5)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params.merge(user_id: current_user.id, comments_counter: 0, likes_counter: 0))
    if @post.save
      @post.update_post_counter
      flash[:notice] = 'Your post has been created.'
      redirect_to [@post.user, @post]
    else
      redirect_to [:new_user_post]
      flash[:alert] = 'Your post failed to create, make sure you properly filled the title'
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
