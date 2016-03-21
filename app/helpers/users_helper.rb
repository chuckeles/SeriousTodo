module UsersHelper

  def gravatar_for(user)
    id = Digest::MD5::hexdigest(user.email.downcase)
    url = "https://secure.gravatar.com/avatar/#{id}?s=200"

    image_tag(url, alt: user.name)
  end

end
