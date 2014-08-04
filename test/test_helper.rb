require "minitest/autorun"
require "mocha/test_unit"

require "err"

%w{
  airbrake
  honeybadger
  opbeat
}.each do |service|
  require service
end