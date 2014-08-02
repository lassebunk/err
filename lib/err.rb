%w{
  version
  service
}.each { |f| require "err/#{f}" }

module Err
  class << self
    def setup!
      return if @set_up
      @set_up = true
    end

    def services
    end
  end
end
