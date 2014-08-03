module Err
  class Honeybadger < Service
    class << self
      def available?
        defined?(::Honeybadger)
      end

      def configure(&block)
        return unless enabled?
        honeybadger.configure(&block)
      end

      def environments=(envs)
        config.development_environments -= envs.map(&:to_s)
      end

      def ignore=(exception_names)
        config.ignore.clear
        config.ignore.concat exception_names
      end

      def notify(exception, params = {})
        honeybadger.notify_or_ignore(exception, parameters: params)
      end

      def message(msg, params = {})
        honeybadger.notify(msg, parameters: params)
      end

      private

      def honeybadger
        ::Honeybadger
      end

      def config
        honeybadger.configuration
      end
    end
  end
end