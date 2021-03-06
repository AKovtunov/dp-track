# coding: UTF-8

require 'sinatra'
require './helpers/ApplicationHelper'
use Rack::Static, :urls => ['/assets', '/assets/js'], :root => 'public'
# set html.erb as herb
Tilt.register Tilt::ERBTemplate, 'html.erb'
def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end
#root route 
get '/' do
  #rendering index as index.html.erb file in index_frame.html.erb layout 
  herb :index, :layout => (request.xhr? ? false : :index_frame)
end
#route with number
get '/route/:number', :provides => [:html, :json] do
  #rendering route as route.html.erb file in frame.html.erb layout 
  herb :route, :locals => { :number => params[:number] }, :layout => (request.xhr? ? false : :frame)
end

