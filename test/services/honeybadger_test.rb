require "test_helper"

class HoneybadgerTest < Minitest::Test
  def test_key
    assert_equal "honeybadger", Err::Honeybadger.key
  end

  def test_enabled
    assert Err::Honeybadger.enabled?
  end

  def test_configure
    Err.configure do |config|
      config.honeybadger do |config|
        config.api_key = "123"
      end
    end
    assert_equal "123", Honeybadger.configuration.api_key
  end

  def test_configure_separate
    Err.configure :honeybadger do |config|
      config.api_key = "456"
    end
    assert_equal "456", Honeybadger.configuration.api_key
  end

  def test_configure_development_environments
    Err.configure do |config|
      config.development_environments = %w{development staging}
    end
    assert Honeybadger.configuration.development_environments.include?("staging")
  end

  def test_configure_ignore
    Err.configure do |config|
      config.ignore = %w{
        ActiveRecord::RecordNotFound
        ActionController::RoutingError
      }
    end

    assert_equal %w{ ActiveRecord::RecordNotFound ActionController::RoutingError },
                 Honeybadger.configuration.ignore
  end

  def test_notify
    Honeybadger.expects(:notify_or_ignore).once
    Err::Honeybadger.notify RuntimeError.new
  end

  def test_message
    Honeybadger.expects(:notify).once
    Err::Honeybadger.message "This is a test", one: "First", two: "Second"
  end
end