require 'rubygems'
require 'sinatra'
require 'multi_json'
require 'data_mapper'
require 'haml'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/weightonplanet.db")

class Planet
  include DataMapper::Resource
  
  property :id,     Serial
  property :name,   String
  property :ratio,  Float
end

Planet.finalize
Planet.auto_upgrade!

get '/weight/:weight/from/:from/to/:to.json' do
  content_type :json
  
  from_planet = Planet.first(name: params[:from])
  to_planet = Planet.first(name: params[:to])
  from_weight = params[:weight]
  
  if from_planet.nil? || to_planet.nil? || from_weight.nil? then
    status 404
  else
    to_weight = (from_weight.to_f / from_planet.ratio) * to_planet.ratio
    MultiJson.dump({to_planet.name.to_sym => to_weight.to_s}, pretty: true)
  end
end

get '/planets.json' do
  content_type :json
  
  MultiJson.dump(planets: Planet.all.map(&:name).sort)
end

get '/' do
  haml :home
end