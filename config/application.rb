require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DottyDns
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_job.queue_adapter = :good_job
    config.good_job.preserve_job_records = true
    config.good_job.retry_on_unhandled_error = false
    config.good_job.on_thread_error = ->(exception) do
      Rails.error.report(exception)
    end
    config.good_job.execution_mode = :external
    config.good_job.queues = "*"
    config.good_job.max_threads = 5
    config.good_job.poll_interval = 30 # seconds
    config.good_job.shutdown_timeout = 25 # seconds
    config.good_job.enable_cron = true
    config.good_job.cron = {
      # example: {
      #   cron: "0 * * * *",
      #   class: "ExampleJob"
      # }
    }
    config.good_job.dashboard_default_locale = :en
  end
end
