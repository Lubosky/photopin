require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PhotoPin
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.action_mailer.default_url_options = { :host => ENV.fetch('SMTP_1_DOMAIN', 'localhost:3000') }
    config.action_mailer.smtp_settings = {
      address: ENV.fetch('SMTP_1_ADDRESS', 'localhost'),
      port: ENV.fetch('SMTP_1_PORT', 1025).to_i,
      domain: ENV.fetch('SMTP_1_DOMAIN', 'localhost:3000'),
      authentication: ENV.fetch('SMTP_1_AUTHENTICATION', nil),
      enable_starttls_auto: ENV.fetch('SMTP_1_ENABLE_STARTTLS_AUTO', 'false') == 'true',
      user_name: ENV.fetch('SMTP_1_USER_NAME', nil),
      password: ENV.fetch('SMTP_1_PASSWORD', nil),
      openssl_verify_mode: ENV.fetch('SMTP_1_OPENSSL_VERIFY_MODE', nil),
    }
  end
end
