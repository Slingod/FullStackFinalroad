Rails.application.configure do
  # Reload code changes without restarting the server
  config.enable_reloading = true
  config.cache_classes = false
  config.reload_classes_only_on_change = false

  # Do not eager load code on boot
  config.eager_load = false

  # Show full error reports
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Disable caching (prevents loading outdated assets or views)
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Store uploaded files on the local file system
  config.active_storage.service = :local

  # Email settings for development
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.mailer_sender = 'no-reply@myapp.com'
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # SMTP configuration (ensure ENV variables are set)
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"]
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs
  config.active_record.verbose_query_logs = true

  # Raise error for missing translations
  config.i18n.raise_on_missing_translations = true

  # Debugging: Show which layout is being used in logs
  config.action_view.annotate_rendered_view_with_filenames = true

  # =============================
  # 🚀 ASSET CONFIGURATION
  # =============================

  # Prevent assets from being cached
  config.assets.debug = true

  # Disable checking of precompiled assets
  config.assets.check_precompiled_asset = false
end
