module Marchflux
	module Test
		module Fixtures
			class Users
				def self.build
					['danndalf', 'jburrows'].each do |user|
						unless User.where(name: user, service: 'twitter').first
							puts "   - User #{user} not found in twitter service. Creating."
							User.create(name: user, service: 'twitter')
						end
					end					
				end
			end
		end
	end
end
