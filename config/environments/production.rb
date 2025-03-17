require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings.
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Enable caching.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry.
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Assume all access to the app is happening through an SSL reverse proxy.
  config.assume_ssl = true
  config.force_ssl = true

  # Log to STDOUT with request id.
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)

  # Set log level.
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Do not log any deprecations.
  config.active_support.report_deprecations = false

  # Replace default cache store.
  config.cache_store = :solid_cache_store

  # Use a queue backend for Active Job.
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  # ✅ Devise mailer sender
  config.mailer_sender = 'no-reply@monapp.com'

  # ✅ Configuration de l'URL pour les emails en production
  config.action_mailer.default_url_options = { host: 'monapp.com', protocol: 'https' }

  # ✅ Configuration SMTP pour envoyer des emails
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "monapp.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: Rails.application.credentials.dig(:smtp, :user_name),  # Stocké de manière sécurisée
    password: Rails.application.credentials.dig(:smtp, :password)     # Stocké de manière sécurisée
  }

  # Enable locale fallbacks for I18n.
  config.i18n.fallbacks = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
