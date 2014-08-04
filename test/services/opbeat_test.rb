require "test_helper"

class OpbeatTest < Minitest::Test
  def test_key
    assert_equal "opbeat", Err::Opbeat.key
  end

  def test_enabled
    assert Err::Opbeat.enabled?
  end

  def test_configure
    Opbeat.expects(:configure).once
    Err::Opbeat.configure do |config|
    end
  end

  def test_configure_development_environments
    Err.configure do |config|
      config.development_environments = %w{development production}
    end
    assert !Opbeat.configuration.environments.include?("production")
  end

  def test_configure_ignore
    Err.configure do |config|
      config.ignore = %w{
        ActiveRecord::RecordNotFound
        ActionController::RoutingError
      }
    end

    assert_equal %w{ ActiveRecord::RecordNotFound ActionController::RoutingError },
                 Opbeat.configuration.excluded_exceptions
  end

  def test_notify
    Opbeat.expects(:captureException).once
    Err::Opbeat.notify RuntimeError.new
  end

  def test_message
    Opbeat.expects(:captureMessage).once
    Err::Opbeat.message "This is a test", one: "First", two: "Second"
  end
end