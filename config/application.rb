require File.expand_path("../boot", __FILE__)

require "rails/all"
require "csv"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BaseApp
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
