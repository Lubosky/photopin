class RegistrationsController < Devise::RegistrationsController

  protected

  def devise_parameter_sanitizer
    if resource_class == User
      UserParams.new(User, :user, params)
    else
      super
    end
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

end
