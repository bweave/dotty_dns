ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/focus"
require "sidekiq/testing"
require "webmock/minitest"

Rails.root.glob("test/support/*_test_help.rb").each { |file| require file }

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def self.described_class
      name.gsub(/Test(::|$)/, "\\1").constantize
    end

    def described_class
      self.class.described_class
    end
  end
end
