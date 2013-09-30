# coding: UTF-8

require 'sinatra'
require './helpers/ApplicationHelper'

# set html.erb as herb
Tilt.register Tilt::ERBTemplate, 'html.erb'
def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end
#do routes
get '/' do
  herb :index
end

get '/route/:number', :provides => [:html, :json, :js] do
  herb :route, :locals => { :number => params[:number] }#, :layout => :post
end

