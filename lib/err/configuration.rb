module Err
  module Configuration
    DEFAULT_ENVIRONMENTS = %w{  }
    DEFAULT_IGNORE = %w{

    }

    def environments
      @environments ||= DEFAULT_ENVIRONMENTS.dup
    end

    attr_writer :environments

    def ignore
      @ignore ||= DEFAULT_IGNORE.dup
    end

    attr_writer :ignore
  end
end