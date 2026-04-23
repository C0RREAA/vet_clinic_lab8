ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # No cargamos fixtures — usamos datos creados en cada test
    self.use_transactional_tests = true
  end
end