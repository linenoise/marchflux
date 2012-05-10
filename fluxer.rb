#!/usr/bin/env ruby

require 'rubygems'
require 'tweetstream'
require 'json'
require 'colored'
require 'yaml'

def track_tweetstream
	client = load_client
	hashtags = ARGV

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

def load_client
	auth = YAML::load( File.open( 'authentication.yml' ) )

	if auth.nil?
		puts "Unable to connect to twitter without authentication."
		puts "Please register a twitter client and populate its keys in authentication.yml."
		exit 1
	end

	TweetStream.configure do |config|
		 config.consumer_key = auth['consumer_key']
		 config.consumer_secret = auth['consumer_secret']
		 config.oauth_token = auth['oauth_token']
		 config.oauth_token_secret = auth['oauth_token_secret']
		 config.auth_method = :oauth
		 config.parser = :yajl
	end

	client = TweetStream::Client.new
	return client
end

track_tweetstream
