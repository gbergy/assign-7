class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
  end

  def show
     @post = Post.where(id: params[:id]).first 
     @user = User.find(params[:user_id])
  end

  def destroy
    @post = Post.where(id: params[:id]).first
    if @post && @post.destroy
      flash[:notice] = "Post: #{@post.title} deleted successfully!"
      redirect_to user_posts_path(@post.user)
    else
      flash[:alert] = "There was a problem destroying"
      redirect_to :back
    end
  end

  def new
    @post = Post.new
  end

  def create 
    @post = Post.new(post_params)
    @post.user = current_user #Associate post to a specific user 
    if @post.save
      flash[:notice] = "Post #{@post.title} was created
      successfully."
      redirect_to user_path(current_user)
    else
      flash[:alert] = "There was a problem saving post."
      redirect_to new_user_post_path(@post.user)
    end
  end 

  def edit
    @post = Post.find(params[:id])
    # @user = User.find(params[:user_id])
    # @post.user = User.find(params[:user_id])
  end

  def update 
    @post = Post.find(params[:id]) 
    if @post.update_attributes(post_params)
      flash[:notice] = "Your post was updated
      successfully."
    else
      flash[:alert] = "There was a problem saving your
      post."
    end
    redirect_to user_post_path(params[:user_id], @post)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :body, :title)
  end
end
