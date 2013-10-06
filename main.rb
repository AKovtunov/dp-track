# coding: UTF-8

require 'sinatra'
require './helpers/ApplicationHelper'
use Rack::Static, :urls => ['/assets', '/assets/js'], :root => 'public'
# set html.erb as herb
Tilt.register Tilt::ERBTemplate, 'html.erb'
def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end
#do routes
get '/' do
  herb :index
end

get '/route/:number', :provides => [:html, :json] do
  herb :route, :locals => { :number => params[:number] }, :layout => (request.xhr? ? false : :frame)
end

