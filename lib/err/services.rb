require "err/services/service"

Dir["#{File.dirname(__FILE__)}/services/*.rb"].each { |f| require f }