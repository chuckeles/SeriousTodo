Rails.application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_files = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass
  config.assets.compile = false
  config.assets.digest = true
  config.force_ssl = true
  config.log_level = :warn
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  config.active_mailer.default_url_options = { host: Rails.application.secrets.domain_name }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: Rails.application.secrets.mailer_address,
    port: 587,
    authentication: :plain,
    user_name: Rails.application.secrets.mailer_username,
    password: Rails.application.secrets.mailer_password,
    domain: Rails.application.secrets.domain,
    enable_starttls_auto: true
  }

end
