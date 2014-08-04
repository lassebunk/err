module Err
  module Configuration
    DEFAULT_DEVELOPMENT_ENVIRONMENTS = %w{ development test cucumber }
    DEFAULT_IGNORE = %w{
      ActiveRecord::RecordNotFound,
      ActionController::RoutingError,
      ActionController::InvalidAuthenticityToken,
      CGI::Session::CookieStore::TamperedWithCookie,
      ActionController::UnknownHttpMethod,
      ActionController::UnknownAction,
      AbstractController::ActionNotFound,
      Mongoid::Errors::DocumentNotFound,
      ActionController::UnknownFormat
    }

    class << self
      def development_environments
        @development_environments ||= DEFAULT_DEVELOPMENT_ENVIRONMENTS.dup
      end

      attr_writer :development_environments

      def ignore
        @ignore ||= DEFAULT_IGNORE.dup
      end

      attr_writer :ignore

      def method_missing(method, *args, &block)
        if service = Err.find_service_by_key(method)
          service.configure(&block)
        else
          super
        end
      end
    end
  end
end