require 'rubygems'
require 'sinatra'
require 'multi_json'
require 'data_mapper'

before do
  content_type 'application/json'
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/weightonplanet.db")

class Planet
  include DataMapper::Resource
  
  property :id,     Serial
  property :name,   String
  property :ratio,  Float
end

Planet.auto_upgrade!

get '/' do
  from_planet = params[:from]
  to_planet = params[:to]
  from_weight = params[:weight]
  
  if from_planet.nil? || to_planet.nil? || from_weight.nil? then
    status 404
  else
    to_weight = (from_weight.to_f / Planet.first(name: from_planet).ratio) * Planet.first(name: to_planet).ratio
    MultiJson.dump({to_planet.to_sym => to_weight.to_s}, pretty: true)
  end
end