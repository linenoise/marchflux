#!/usr/bin/env ruby

module Marchflux
	class Fluxer

		def self.track_twitter_hashtags
			hashtags = Hashtag.all.map{|h| h.name}
			puts "Tracking tweetstream for #{hashtags.join(', ')}."

			self.twitter_streaming_client.track(hashtags) { |status|
				puts "-----\nuser id: #{status[:user][:id]}"
				puts "recorded_at: #{status[:created_at]}"
				latitude = nil
				longitude = nil
				if status[:geo] && status[:geo][:type] == 'Point'
					latitude = status[:geo][:coordinates][0]
					puts "latitude: #{status[:geo][:coordinates][0]}" 
					longitude = status[:geo][:coordinates][1]
					puts "longitude: #{status[:geo][:coordinates][1]}" 
				end
				puts "description: #{status[:text]}"
				
				Flux.create(
				 	service: 'twitter',
				 	id_on_service: status[:id],
				 	user_id: status[:user][:id],
				 	recorded_at: status[:created_at],
					latitude: latitude,
					longitude: longitude,
				 	description: status[:text],
				 	raw_json: status.to_json
				)
			}
		end

		def self.track_twitter_users

			# Make sure we have an ID for each user
			User.where(service: 'twitter').each do |user|
				unless user.id_on_service
					puts "   - Looking up user_id for #{user.name}"
					twitter_user = Twitter.user(user.name)
					if twitter_user[:id]
						user.id_on_service = twitter_user[:id]
						user.save
					else
						puts "   - Cannot find user_id for #{user.name}.  Skipping."
					end
				end
			end

			user_ids = User.where(service: 'twitter').map{|u| u.user_id }
			user_names = User.where(service: 'twitter').map{|u| u.name }

			puts "Tracking tweetstream for #{user_names.join(', ')} (IDs: #{user_ids.join(', ')})."
			self.twitter_streaming_client.follow(user_ids) { |status|
				# File.open("#{where_fluxes_go}/#{status.id_str}.json", 'w') do |flux|
				# 	flux.puts status.to_json
				# end
				puts '['.yellow + status.user.screen_name.green + '] '.yellow + status.text
			}
		end

		private

		def self.twitter_streaming_client
			auth = YAML::load( File.open( './authentication.yml' ) )

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
			return client.on_error { |message|
				puts "Error: #{message}"
				sleep 60 * 3
			}.on_limit {|skip_count|
				sleep 10
			}
		end

	end
end
