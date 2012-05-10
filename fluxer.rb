#!/usr/bin/env ruby

require 'rubygems'
require 'tweetstream'
require 'json'
require 'colored'
require 'yaml'

def load_auth
	if auth = YAML::load( File.open( 'authentication.yml' ) )
		return auth
	end
	puts "Please load a Twitter consumer key, secret, and oauth vector into authentication.yml"
	return nil
end

def load_client
	auth = load_auth
	if auth.nil?
		puts "Unable to connect to twitter without authentication."
		exit 1
	end

	TweetStream.configure do |config|
		 config.consumer_key = auth['consumer_key']
		 config.consumer_secret = auth['consumer_secret']
		 config.oauth_token = auth['oauth_token']
		 config.oauth_token_secret = auth['oauth_token_secret']
		 config.auth_method = :oauth
		 config.parser   = :yajl
	end

	client = TweetStream::Client.new
	return client
end

def prepare_fluxes_directory(hashtags)
	fluxes_dir = "#{Dir.pwd}/fluxes}"
	Dir.mkdir(fluxes_dir) unless Dir.exists?(fluxes_dir)

	where_fluxes_go = "#{Dir.pwd}/fluxes/tags_#{hashtags.join('_')}"
	Dir.mkdir(where_fluxes_go) unless Dir.exists?(where_fluxes_go)

	if Dir.exists?(where_fluxes_go)
		return where_fluxes_go
	end

	puts "Unable to find or create #{where_fluxes_go}."
	puts "Please create this manually, ensure this script can write there, and re-run this."

	exit 1
end

def track_tweetstream
	client = load_client
	hashtags = ARGV
	where_fluxes_go = prepare_fluxes_directory(hashtags)

	puts "Tracking tweetstream for #{hashtags.join(', ')}..."
	puts "Use ^C to exit."

	client.on_error do |message|
		puts "Error: #{message}"
  end.track(hashtags) do |status|
		File.open("#{where_fluxes_go}/#{status.id_str}.json", 'w') do |flux|
			flux.puts status.to_json
		end
	  puts '['.yellow + status.user.screen_name.green + '] '.yellow + status.text
	end
end

track_tweetstream
