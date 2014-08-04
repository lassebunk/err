require "test_helper"

class AirbrakeTest < Minitest::Test
  def test_key
    assert_equal "airbrake", Err::Airbrake.key
  end

  def test_enabled
    assert Err::Airbrake.enabled?
  end

  def test_configure
    Airbrake.expects(:configure).once
    Err::Airbrake.configure do |config|
    end
  end

  def test_configure_development_environments
    Err.configure do |config|
      config.development_environments = %w{development staging}
    end
    assert Airbrake.configuration.development_environments.include?("staging")
  end

  def test_configure_ignore
    Err.configure do |config|
      config.ignore = %w{
        ActiveRecord::RecordNotFound
        ActionController::RoutingError
      }
    end

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