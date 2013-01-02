# coding: UTF-8

require 'sinatra'
#require 'dalli'
#require 'memcachier'
require 'json'
require 'geocoder'
require 'mechanize'

# prepare memcache client
#set :cache, Dalli::Client.new

# prepare geocoder
Geocoder.configure(:lookup => :yandex, :language => :ru)

# getting current information
def get_info

  req = Mechanize.new.get 'http://transit.in.ua/importTransport.php?dataRequest%5B%5D=dnepropetrovsk-taxi-20&dataRequest%5B%5D=dnepropetrovsk-taxi-33&dataRequest%5B%5D=dnepropetrovsk-taxi-127'

  data = []

  Geocoder.configure(:lookup => :yandex, :language => :ru)
  
  (JSON.load req.body).each do |raw_way|

    place = Geocoder.search((raw_way['cordinate'].to_s)[1..-2]).first.data['GeoObject']['metaDataProperty']['GeocoderMetaData']['text']

    # formating place
    place = place.split(',')[4..-1].join(',')

    data << ({:info => raw_way['info'], :place => place})

  end

  #settings.cache.set('data', data)

  data

end


get '/' do

  get_info.to_json

end

