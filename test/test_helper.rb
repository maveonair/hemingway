ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'mocha/mini_test'
require 'codeclimate-test-reporter'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

CodeClimate::TestReporter.start

OmniAuth.config.test_mode = true

class ActiveSupport::TestCase
  fixtures :all

  def login(fixture_name)
    user = users(fixture_name)
    session[:user_id] = user.id
    user
  end

  def read_fixture(filename)
    file_path = Rails.root.join('test', 'fixtures', filename)
    File.read(file_path)
  end
end
