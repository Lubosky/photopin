module AvatarHelper
  def user_avatar(resource, options = {})
    if resource.avatar.nil?
      image_tag resource.avatar_url, options
    else
      image_tag resource.avatar.thumb('120x120#').url, options
    end
  end
end
