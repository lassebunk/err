module Err
  class Service
    class << self
      def key
        @key ||= name.split("::").last.gsub(/^./, &:downcase).gsub(/[A-Z]/) { |s| "_#{s.downcase}" }
      end

      def available?
        raise NotImplementedError
      end

      def enabled?
        available?
      end

      def configure(&block)
        raise NotImplementedError
      end

      def development_environments=(envs)
        raise NotImplementedError
      end

      def ignore=(exception_names)
        raise NotImplementedError
      end

      def notify(exception, params = {})
        raise NotImplementedError
      end

      def message(msg, params = {})
        raise NotImplementedError
      end
    end
  end
end