#!/usr/bin/env ruby
load 'lib/bootstrap.rb'
load 'lib/fluxer.rb'

require 'daemon_spawn'

module Marchflux
	module Fluxers
		class TwitterHashtags < DaemonSpawn::Base
			def start(args)
				Marchflux::Fluxer.track_twitter_hashtags
			end
			def stop
			end
		end
	end
end

Marchflux::Fluxers::TwitterHashtags.spawn!(
	:log_file => './logs/twitter_hashtags.log',
	:pid_file => './pids/twitter_hashtags.pid',
	:sync_log => true,
	:working_dir => File.dirname(__FILE__) + '/../'
)
