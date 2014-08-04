%w{
  version
  configuration
  services
}.each { |f| require "err/#{f}" }

module Err
  class << self
    def configure(service_key = nil, &block)
      if service_key
        service = find_service_by_key(service_key)
        raise "Service #{service_key.inspect} not found" unless service
        service.configure(&block)
      else
        yield config
      end
      setup!
    end

    def notify(exception, params = {})
      call_each_service :notify, exception, params
    end

    def message(msg, params = {})
      call_each_service :message, msg, params
    end

    def setup!
      [:development_environments, :ignore].each do |method|
        call_each_service "#{method}=", config.send(method)
      end
    end

    def services
      @services ||= ObjectSpace.each_object(Class).select { |klass| klass < Err::Service }
    end

    def enabled_services
      services.select(&:enabled?)
    end

    private

    def config
      Configuration
    end

    def find_service_by_key(key)
      services.find { |s| s.key == key.to_s }
    end

    def call_each_service(method, *args)
      enabled_services.each do |s|
        s.send method, *args
      end
    end
  end
end
