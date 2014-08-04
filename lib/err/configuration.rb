module Err
  module Configuration
    DEFAULT_DEVELOPMENT_ENVIRONMENTS = %w{  }
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
    end
  end
end