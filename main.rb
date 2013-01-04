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
def get_info  (ways)

  url = 'http://transit.in.ua/importTransport.php?'

  # create url for fetching ways
  ways.each do |way|
    url = url + 'dataRequest%5B%5D=dnepropetrovsk-taxi-'+way.to_s+'&'
  end

  # here will be saved parsed data
  data = []

  # fetch data from web
  req = Mechanize.new.get url


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

  get_info([127, 33, 20]).to_json

end

