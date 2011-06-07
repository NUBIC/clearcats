Clearcats::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The staging environment is meant to demo finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local                   = false
  config.action_controller.perform_caching             = true
  # config.action_view.cache_template_loading            = true
  #   deploy causes: undefined method `cache_template_loading=' for ActionView::Base:Class

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  config.middleware.use ExceptionNotifier,
    :email_prefix => "[clearcats] ",
    :sender_address => %("ClearCATS Application Error" <clearcats@northwestern.edu>),
    :exception_recipients => %w(clearcats-tech-support@northwestern.edu)

  config.after_initialize do
    Bcsec.configure do
      ui_mode :cas
      api_mode :cas_proxy
      authorities :cas, :automatic_access, :netid, :pers
      central '/etc/nubic/bcsec-staging.yml'
    end
  
    # Bcsec.configure do
    #   ui_mode :form
    #   authorities :automatic_access, :netid, :pers
    #   central '/etc/nubic/bcsec-staging.yml'
    # end
  end
end