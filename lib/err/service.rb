module Err
  class Service
    class << self
      def enabled?
        raise NotImplementedError
      end

      def environments=(envs)
        raise NotImplementedError
      end

      def ignored=(exception_names)
        raise NotImplementedError
      end

      def notify(exception)
        raise NotImplementedError
      end

      def message(msg)
        raise NotImplementedError
      end
    end
  end
end