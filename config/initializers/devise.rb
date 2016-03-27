Devise.setup do |config|
  require "devise/orm/active_record"

  config.mailer_sender = "please-dont-reply@serious-todo.com"
  config.send_password_change_notification = false
  config.sign_out_via = :delete

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10

  config.confirm_within = 3.days
  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true
  config.rememberable_options = { secure: true }

  config.password_length = 8..72
  config.email_regexp = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  config.reset_password_within = 6.hours
  config.sign_in_after_reset_password = false

end
