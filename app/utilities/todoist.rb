require_relative "cache"

# TODO: Refactor into a base class and make Todoist inherit it
#       to allow other integrations later (and DRY)
class Todoist

  @@authorize_url = "https://todoist.com/oauth/authorize"
  @@token_url = "https://todoist.com/oauth/access_token"
  @@sync_url = "https://todoist.com/API/v6/sync"

  def self.connected?(user)
    user.todo_apps.any?
  end

  def self.connection(user)
    user.todo_apps.first
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

  # TODO: Refactor this mess
  def self.items(user, flash)
    cache_key = "user#{ user.id }_todoist_items"
    items = Cache.get(cache_key)

    if items
      items = JSON.parse(items).map do |item|
        {
          id: item["id"],
          content: item["content"],
          due: item["due"],
          source: "Todoist"
        }
      end
    else
      url = URI(@@sync_url)
      token = AES.decrypt(connection(user).token, Rails.application.secrets.secret_key_base)
      result = Net::HTTP.post_form(url, token: token, seq_no: 0, resource_types: '["items"]')
      json_body = JSON.parse(result.body)

      if json_body["error"] and json_body["error"] == "Invalid token"
        connection(user).destroy
        flash[:danger] = "Invalid token! Please connect the todo app again."
        false
      end

      items = json_body["Items"].map do |item|
        {
          id: item["id"],
          content: item["content"],
          due: item["due_date_utc"] ? DateTime.parse(item["due_date_utc"]) : nil,
          source: "Todoist"
        }
      end
      items.sort do |a, b|
        a[:content] <=> b[:content]
      end

      Cache.set(cache_key, items.to_json)
    end

    items
  end

end
