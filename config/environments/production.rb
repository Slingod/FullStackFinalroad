require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Do not reload code between requests (for performance)
  config.enable_reloading = false

  # Eager load code on boot for better performance
  config.eager_load = true

  # Full error reports are disabled
  config.consider_all_requests_local = false

  # Enable caching for better performance in production
  config.action_controller.perform_caching = true

  # Cache assets for a long duration
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=#{1.year.to_i}"
  }

  # Force SSL for security
  config.assume_ssl = true
  config.force_ssl = true

  # Log to STDOUT with request ID
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)

  # Set log level
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Do not log deprecations
  config.active_support.report_deprecations = false

  # Use a cache store for better performance
  config.cache_store = :solid_cache_store

  # Use a queue backend for Active Job
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  # ✅ Devise mailer sender
  config.mailer_sender = 'no-reply@myapp.com'

  # ✅ Configure URL for emails in production
  config.action_mailer.default_url_options = { host: 'myapp.com', protocol: 'https' }

  # ✅ SMTP configuration for sending emails
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "myapp.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: Rails.application.credentials.dig(:smtp, :user_name),  # Stocké en toute sécurité
    password: Rails.application.credentials.dig(:smtp, :password)     # Stocké en toute sécurité
  }

  # ✅ Envoi d'emails de confirmation d'inscription Devise
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  # Enable locale fallbacks for I18n
  config.i18n.fallbacks = true

  # Do not dump schema after migrations
  config.active_record.dump_schema_after_migration = false

  # Ensure assets are compiled and served correctly
  config.assets.compile = true
  config.assets.digest = true
  config.assets.prefix = '/assets'
end
