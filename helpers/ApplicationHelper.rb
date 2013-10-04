#require 'dalli'
#require 'memcachier'
require 'json'
require 'geocoder'
require 'mechanize'

Geocoder.configure(:lookup => :google, :language => :ru)

def get_data_from route_number
  url = 'http://transit.in.ua/importTransport.php?'
  url = url + 'dataRequest%5B%5D=dnepropetrovsk-taxi-'+route_number.to_s+'&'
  req = Mechanize.new.get url
  @data_array = JSON.load req.body
  
end

def info_about coords 
  s = Geocoder.search("#{coords[0]},#{coords[1]}")
 
end

def make_view route_number
  data = get_data_from route_number
end
