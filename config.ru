require "rubygems"
require "bundler/setup"
require_relative "app"

if(ENV["NEW_RELIC"] == 1.to_s)
  require "newrelic_rpm"
  require "new_relic/agent/instrumentation"
end

run Feeder
