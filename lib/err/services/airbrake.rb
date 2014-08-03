module Err
  class Airbrake < Service
    class << self
      def available?
        defined?(::Airbrake)
      end

      def configure(&block)
        return unless enabled?
        airbrake.configure(&block)
      end

      def environments=(envs)
        config.development_environments -= envs.map(&:to_s)
      end

      def ignore=(exception_names)
        config.ignore.clear
        config.ignore.concat exception_names
      end

      def notify(exception, params = {})
        airbrake.notify_or_ignore(exception, parameters: params)
      end

      def message(msg, params = {})
        airbrake.notify(msg, parameters: params)
      end

      private

      def airbrake
        ::Airbrake
      end

      def config
        airbrake.configuration
      end
    end
  end
end