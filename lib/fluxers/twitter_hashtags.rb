module Marchflux
	module Fluxers
		class TwitterHashtags < DaemonSpawn::Base

			def start(args)
				# process command-line args
				# start your bad self
			end

			def stop
				# stop your bad self
			end

		end
	end
end

Marchflux::Fluxers::TwitterHashtags.spawn!(:log_file => '/var/log/echo_server.log',
	:pid_file => '/var/run/echo_server.pid',
	:sync_log => true,
	:working_dir => File.dirname(__FILE__))
