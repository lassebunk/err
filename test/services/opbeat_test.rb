require "test_helper"

class OpbeatTest < Minitest::Test
  def test_key
    assert_equal "opbeat", Err::Opbeat.key
  end

  def test_enabled
    assert Err::Opbeat.enabled?
  end

  def test_configure
    Err.configure do |config|
      config.opbeat do |config|
        config.organization_id = "123"
      end
    end
    assert_equal "123", Opbeat.configuration.organization_id
  end

  def test_configure_separate
    Err.configure :opbeat do |config|
      config.organization_id = "456"
    end
    assert_equal "456", Opbeat.configuration.organization_id
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