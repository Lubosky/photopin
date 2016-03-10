class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    if @post = Post.create(post_params)
      flash[:success] = 'Your post has been successfully created!'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Ooops! We\'re having trouble creating your post. Please check your form.'
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
      flash.now[:alert] = 'Sorry! We\'re having trouble updating your post.'
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end

end
