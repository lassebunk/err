require "test_helper"

class AirbrakeTest < Test::Unit::TestCase
  def test_enabled
    assert Err::Airbrake.enabled?
  end

  def test_configure
    Airbrake.expects(:configure).once
    Err::Airbrake.configure do |config|
    end
  end

  def test_set_environments
    config = Airbrake.configuration
    assert config.development_environments.include?("development")
    Err::Airbrake.environments = %w{development staging}
    assert !config.development_environments.include?("development")
    assert !config.development_environments.include?("staging")
    assert config.development_environments.include?("test")
  end

  def test_set_ignore
    Err::Airbrake.ignore = %w{
      ActiveRecord::RecordNotFound
      ActionController::RoutingError
    }

    assert_equal %w{ ActiveRecord::RecordNotFound ActionController::RoutingError },
                 Airbrake.configuration.ignore
  end

  def test_notify
    Airbrake.expects(:notify_or_ignore).once
    Err::Airbrake.notify RuntimeError.new
  end

  def test_message
    Airbrake.expects(:notify).once
    Err::Airbrake.message "This is a test", one: "First", two: "Second"
  end
end