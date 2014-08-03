module Err
  class Opbeat < Service
    class << self
      def available?
        defined?(::Opbeat)
      end

      def configure(&block)
        return unless enabled?
        opbeat.configure(&block)
      end

      def environments=(envs)
        config.environments = envs.map(&:to_s)
      end

      def ignore=(exception_names)
        config.excluded_exceptions = exception_names
      end

      def notify(exception, params = {})
        opbeat.captureException(exception)
      end

      def message(msg, params = {})
        msg = msg.dup
        msg << " (#{params_string(params)})" if params.any?
        opbeat.captureMessage(msg)
      end

      private

      def params_string(params)
        params.map { |k, v| "#{k}: #{v}" }.join(", ")
      end

      def opbeat
        ::Opbeat
      end

      def config
        opbeat.configuration
      end
    end
  end
end