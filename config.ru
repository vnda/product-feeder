require "rubygems"
require "bundler/setup"
require_relative "app"

if(ENV["NEW_RELIC"] == 1)
  require "newrelic_rpm"
  require "new_relic/agent/instrumentation"
end

map "/google_merchant" do
  run Feeder
end
