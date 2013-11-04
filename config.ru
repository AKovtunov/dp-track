require './main'
$:.unshift File.expand_path(File.dirname(__FILE__))
require 'newrelic_rpm'
NewRelic::Agent.after_fork(:force_reconnect => true)
run Sinatra::Application

