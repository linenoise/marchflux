load 'lib/bootstrap.rb'

module Marchflux
	module Fluxers
		class TwitterUsers < DaemonSpawn::Base
			def start(args)
				Marchflux::Fluxer.track_twitter_users
			end
			def stop
			end
		end
	end
end

Marchflux::Fluxers::TwitterUsers.spawn!(
	:log_file => './logs/twitter_users.log',
	:pid_file => './pids/twitter_users.pid',
	:sync_log => true,
	:working_dir => File.dirname(__FILE__) + '/../'
)
