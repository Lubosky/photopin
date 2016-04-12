class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :owned_profile, only: [:edit, :update]

  def show
    @posts = @user.posts.order('created_at DESC')
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been successfully updated!'
      redirect_to profile_path
    else
      flash[:alert] = 'Sorry! We are having trouble updating your profile.'
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def profile_params
    params.require(:user).permit(:avatar)
  end

  def owned_profile
    unless current_user == @user
      flash[:alert] = 'Put your hands away from this profile!'
      redirect_to root_path
    end
  end

end
