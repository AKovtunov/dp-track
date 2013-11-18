#require 'dalli'
#require 'memcachier'

#requiring libraries
require 'json'
require 'geocoder'
require 'mechanize'

#configuring geocoder to get data from google
Geocoder.configure(:lookup => :google, :language => :ru)

#method for parsing data
def get_data_from route_number
  #general url
  url = 'http://transit.in.ua/importTransport.php?'
  #url for route number
  url = url + 'dataRequest%5B%5D=dnepropetrovsk-taxi-'+route_number.to_s+'&'
  #get query to url
  req = Mechanize.new.get url
  #reading response as JSON
  @data_array = JSON.load req.body
  
end

#reading geodata about coordinates
def info_about coords 
  #parsing data from 
  s = Geocoder.search("#{coords[0]},#{coords[1]}")
end

#main method to get data about the route for using it in view
def make_view route_number
  data = get_data_from route_number
end
