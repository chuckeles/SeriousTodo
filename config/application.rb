require File.expand_path("../boot", __FILE__)
require "rails/all"
Bundler.require(*Rails.groups)

module SeriousTodo

  class Application < Rails::Application

    config.active_record.raise_in_transactional_callbacks = true
    config.generators do |g|
      g.assets false
      g.template_engine :slim
      g.test_framework :rspec
      g.controller_specs false
      g.view_specs false
      g.helper_specs false
      g.request_specs false
    end

    config.x.name = "Serious Todo"

  end

end
