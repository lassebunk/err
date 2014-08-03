require "test_helper"

class HoneybadgerTest < Test::Unit::TestCase
  def test_key
    assert_equal "honeybadger", Err::Honeybadger.key
  end

  def test_enabled
    assert Err::Honeybadger.enabled?
  end

  def test_configure
    Honeybadger.expects(:configure).once
    Err::Honeybadger.configure do |config|
    end
  end

  def test_set_environments
    config = Honeybadger.configuration
    assert config.development_environments.include?("development")
    Err::Honeybadger.environments = %w{development staging}
    assert !config.development_environments.include?("development")
    assert !config.development_environments.include?("staging")
    assert config.development_environments.include?("test")
  end

  def test_set_ignore
    Err::Honeybadger.ignore = %w{
      ActiveRecord::RecordNotFound
      ActionController::RoutingError
    }

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