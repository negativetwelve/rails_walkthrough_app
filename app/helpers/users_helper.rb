module UsersHelper

  def user_profile_picture_tag(user, size)
    link_to(image_tag(user.profile_picture, size: "#{size}x#{size}"), user)
  end

end
