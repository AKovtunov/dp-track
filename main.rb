# coding: UTF-8

require 'sinatra'
require 'mechanize'

get '/' do

  return '<h1>Page</h1>'

end

get '/fetch' do

  a = Mechanize.new
  req = a.get 'http://transit.in.ua/importTransport.php?dataRequest%5B%5D=dnepropetrovsk-taxi-20&dataRequest%5B%5D=dnepropetrovsk-taxi-33&dataRequest%5B%5D=dnepropetrovsk-taxi-127'
  return req.body

end

