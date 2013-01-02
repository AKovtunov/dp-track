# coding: UTF-8

require 'sinatra'
require 'dalli'
require 'memcachier'

set :cache, Dalli::Client.new

def get_info

  require 'mechanize'

  req = Mechanize.new.get 'http://transit.in.ua/importTransport.php?dataRequest%5B%5D=dnepropetrovsk-taxi-20&dataRequest%5B%5D=dnepropetrovsk-taxi-33&dataRequest%5B%5D=dnepropetrovsk-taxi-127'
  settings.cache.set('data', req.body)

end

get '/' do

  # remove later
  get_info
  
  require 'geocoder'

  Geocoder.configure(

    :api_key => 'AIzaSyAj92jkzuo0TVm_gCNz7dto3WwEt5j3wbo',
    :lookup => :google,
    :language => :ru,
    :timeout => 5,
    :units => :m

  )

  data = ''

  require 'json'

  (JSON.load settings.cache.get('data')).each do |one_way|

    place_geo = Geocoder.search((one_way['cordinate'].to_s)[1..-2])

    # for yandex
    #place = place_geo.first.data['GeoObject']['metaDataProperty']['GeocoderMetaData']['text']

    place = place_geo.first.data['address_components'][1]['short_name'] + ', ' + place_geo.first.data['address_components'][0]['short_name']

    data = data + one_way['info'] + '<br>' + place + '<br><br>'

  end

  data

end

get '/fetch' do

  get_info

end

