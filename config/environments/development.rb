Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
  config.action_mailer.default_url_options = { host: 'localhost', port: 5000 }

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.logger = Logger.new(config.paths["log"].first, 5, 10 * 1024 * 1024)
  config.logger.formatter = Logger::Formatter.new
  config.logger.datetime_format = "%Y/%m/%d %H:%M:%S"
  config.logger.level = Logger::DEBUG
  config.colorize_logging = true
  # resque log
  config.resque_logger = Logger.new(Rails.root.join('log/resque_worker.log'))
end
