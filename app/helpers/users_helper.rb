module UsersHelper

  def gravatar_for(user, options = { size: 100 })
    id = Digest::MD5::hexdigest(user.email.downcase)
    url = "https://secure.gravatar.com/avatar/#{id}?s=#{options[:size]}"

    image_tag(url, alt: user.name)
  end

end
