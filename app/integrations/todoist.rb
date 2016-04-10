class Todoist

  @@authorize_url = "https://todoist.com/oauth/authorize"
  @@sync_url = "https://todoist.com/API/v6/sync"

  def connected?(user)
  end

  def authorize_url
  end

  def authorize(user)
  end

  def items(user)
  end

  def item(user)
  end

end
