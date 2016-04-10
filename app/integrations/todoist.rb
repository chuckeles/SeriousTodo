class Todoist

  @@authorize_url = "https://todoist.com/oauth/authorize"
  @@token_url = "https://todoist.com/oauth/access_token"
  @@sync_url = "https://todoist.com/API/v6/sync"

  def self.connected?(user)
    user.todo_apps.any?
  end

  def self.authorize_url
    @@authorize_url + "?client_id=#{ Rails.application.secrets.todoist_id }&scope=data:read&state=#{ Rails.application.secrets.state }"
  end

  def self.authorize(user, state, code, flash)
    if state != Rails.application.secrets.state
      flash[:danger] = "State does not match! Please try again."
    else
      url = URI(@@token_url)
      result = Net::HTTP.post_form(url, client_id: Rails.application.secrets.todoist_id, client_secret: Rails.application.secrets.todoist_secret, code: code)
      json_body = JSON.parse(result.body)

      if json_body["error"]
        flash[:danger] = "Error getting the token! Please try again."
      else
        user.todo_apps.create(token: AES.encrypt(json_body["access_token"], Rails.application.secrets.secret_key_base))
        flash[:notice] = "Todoist successfully connected."
      end
    end
  end

  def self.items(user)
  end

  def self.item(user)
  end

end
