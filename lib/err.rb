%w{
  version
  services
}.each { |f| require "err/#{f}" }

module Err
  class << self
    def setup!
      return if @set_up
      @set_up = true
    end

    def services
      @services ||= ObjectSpace.each_object(Class).select { |klass| klass < Err::Service && klass.enabled? }
    end

    private

    def call_each_service(method, *args)
      services.each do |s|
        s.send method, *args
      end
    end
  end
end
