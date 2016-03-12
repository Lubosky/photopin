class UserParams < Devise::ParameterSanitizer

  def sign_up
    default_params.permit(:username, :email, :password, :password_confirmation, :remember_me)
  end

  def sign_in
    default_params.permit(:username, :password, :remember_me)
  end

  def account_update
    default_params.permit(:username, :email, :avatar, :password, :password_confirmation, :current_password)
  end

end
