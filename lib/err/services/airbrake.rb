module Err
  class Airbrake < Service
    class << self
      def enabled?
        defined?(::Airbrake)
      end

      def environments=(envs)
        Airbrake.development_environments -= envs.map(&:to_s)
      end

      def ignored=(exception_names)
        Airbrake.ignore << *exception_names
      end

      def notify(exception)
        Airbrake.notify(exception)
      end

      def message(msg)
        Airbrake.notify(message)
      end
    end
  end
end