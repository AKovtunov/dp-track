# coding: UTF-8

require 'sinatra'
require 'dalli'

set :cache, Dalli::Client.new

get '/' do
  
  require 'json'

  data = ''

  (JSON.load settings.cache.get('data')).each do |one_way|

    data = data + one_way['info'] + '<br>'

  end

  data

end

get '/fetch' do

  require 'mechanize'

  req = Mechanize.new.get 'http://transit.in.ua/importTransport.php?dataRequest%5B%5D=dnepropetrovsk-taxi-20&dataRequest%5B%5D=dnepropetrovsk-taxi-33&dataRequest%5B%5D=dnepropetrovsk-taxi-127'
  settings.cache.set('data', req.body)

end

