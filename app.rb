require 'rubygems'
require 'yaml'
require 'mongoid'
require 'sinatra/base'
require 'sinatra/json'


class ModeratorArea < Sinatra::Base
  helpers Sinatra::JSON

  def self.new(*)
    @settings = YAML.load_file( './config.yml' )

  	app = Rack::Auth::Digest::MD5.new(super) do | username |
      @settings['users'][username]
    end
    app.realm = 'Moderator Area'
    app.opaque = 'secretkey'
    app
  end

end

class Hashtags < ModeratorArea

  get '/' do
    json :hastags => %w[#g8, #fuckina]
  end

  get '/*' do | hashtag |
    json :fluxes => %w[hashtag_flux hashtag_flux hashtag_flux]
  end

  post '/' do
    hashtag = params[:hashtag]
    json :success => 1, :hashtag => hashtag
  end

  delete '/*' do | hastag |
    json :success => 1, :hastag => hastag
  end

end

class People < ModeratorArea

  get '/' do
    json :people => %w[@jill,@t,@teknotus]
  end

  get '/*' do |person|
    json :fluxes => %w[person_flux person_flux person_flux]
  end

  post '/' do
    person = param[:person]
    json :success => 1, :person => person
  end

  delete '/*' do | person |
    json :success => 1, :person => person
  end

end

class Channels < ModeratorArea

  get '/' do
    json :channels => %w[health planning food]
  end

  get '/*' do | channel |
    json :fluxes => %w[channel_flux channel_flux channel_flux]
  end

  post '/' do
    channel = params['']
    json :success => 1, :channel => channel
  end

  delete '/*' do | channel |
    json :success => 1, :channel => channel
  end

end

class Fluxes < ModeratorArea

  get '/' do
    json :fluxes => %w[flux_flux flux_flux flux_flux]
  end

  post '/add_to_channel' do
  end

  post '/remove_from_channel' do
  end

end

class Welcome < ModeratorArea

	get '/' do
    erb :index, :locals => { :title => "Stuff" }
  end

end