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
    json :tweets => %w[hashtag_tweet hashtag_tweet hashtag_tweet]
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
    json :tweets => %w[person_tweet person_tweet person_tweet]
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
    json :tweets => %w[channel_tweet channel_tweet channel_tweet]
  end

  post '/' do
    channel = params['']
    json :success => 1, :channel => channel
  end

  delete '/*' do | channel |
    json :success => 1, :channel => channel
  end

end

class Tweets < ModeratorArea

  get '/' do
    json :tweets => %w[tweet_tweet tweet_tweet tweet_tweet]
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