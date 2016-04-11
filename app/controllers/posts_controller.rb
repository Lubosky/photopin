class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Your post has been successfully created!'
      redirect_to posts_path
    else
      flash[:alert] = 'Ooops! We are having trouble creating your post. Please check your form.'
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Your post has been successfully updated!'
      redirect_to posts_path
    else
      flash[:alert] = 'Sorry! We are having trouble updating your post.'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:info] = 'Post has been successfully deleted!'
    redirect_to root_path
  end

  def like
    if @post.liked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def unlike
    if @post.unliked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = 'You cannot edit a post that doesn\'t belong to you!'
      redirect_to root_path
    end
  end

end
