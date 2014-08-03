require "test_helper"

class OpbeatTest < Test::Unit::TestCase
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

  def test_set_environments
    config = Opbeat.configuration
    assert config.environments.include?("production")
    Err::Opbeat.environments = %w{development staging}
    assert !config.environments.include?("production")
    assert config.environments.include?("development")
    assert config.environments.include?("staging")
  end

  def test_set_ignore
    Err::Opbeat.ignore = %w{
      ActiveRecord::RecordNotFound
      ActionController::RoutingError
    }

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