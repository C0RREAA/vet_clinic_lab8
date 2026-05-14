ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # No cargamos fixtures — usamos datos creados en cada test
    self.use_transactional_tests = true
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Sign in a fresh user before each integration test so the
  # `before_action :authenticate_user!` chain doesn't 302 us to
  # /users/sign_in. Tests that want anonymous access can call
  # `sign_out :user` in their own setup.
  setup do
    @current_user = User.create!(
      email:      "tester#{SecureRandom.hex(4)}@example.com",
      password:   "password123",
      first_name: "Test",
      last_name:  "User",
      role:       :admin
    )
    sign_in @current_user
  end
end
