source "https://rubygems.org"

# Security
gem "bcrypt", "~> 3.1.7" # Secure password hashing for Active Model

# Core and Framework Gems
gem "rails", "~> 8.0.1" # Core Rails framework
gem "propshaft" # Modern asset pipeline for Rails
gem "sqlite3", ">= 2.1" # SQLite database for Active Record
gem "puma", ">= 5.0" # Puma web server for handling requests
gem "importmap-rails" # JavaScript with ESM import maps
gem "turbo-rails" # Hotwire's SPA-like page accelerator
gem "stimulus-rails" # Hotwire's modest JavaScript framework
gem "jbuilder" # Build JSON APIs with ease
gem "image_processing", "~> 1.2" # Image processing for Active Storage variants

# Payment Processing
gem "stripe" # Stripe integration for payment processing

# Caching and Performance
gem "tzinfo-data", platforms: %i[ windows jruby ] # Timezone data for Windows and JRuby platforms
gem "solid_cache" # Database-backed adapter for Rails.cache
gem "solid_queue" # Database-backed adapter for Active Job
gem "solid_cable" # Database-backed adapter for Action Cable
gem "bootsnap", require: false # Reduces boot times through caching
gem "kamal", require: false # Deploy the application as a Docker container
gem "thruster", require: false # Add HTTP asset caching/compression and X-Sendfile acceleration to Puma

# Authentication and Authorization
gem "devise", "~> 4.9" # Authentication solution for Rails
gem "pundit" # Authorization library for Rails

# Front-end and Assets
gem "tailwindcss-rails" # Tailwind CSS integration for Rails
gem "bootstrap", "~> 5.1.3" # Front-end framework for building responsive, mobile-first sites
gem "sprockets-rails" # Asset compilation and management

# Internationalization and Environment
gem "rails-i18n" # Rails Internationalization (I18n) support
gem "dotenv-rails", groups: [:development, :test] # Environment variable management

# Development and Testing
group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude" # Debugging gem for Ruby
  gem "brakeman", require: false # Static analysis for security vulnerabilities
  gem "rubocop-rails-omakase", require: false # Ruby style guide enforcement
  gem "listen", "~> 3.0" # File system listener for better development performance
end

group :development do
  gem "web-console" # Console on exception pages for better error insights
end

group :test do
  gem "capybara" # Integration testing with Capybara
  gem "selenium-webdriver" # WebDriver for browser automation
end
