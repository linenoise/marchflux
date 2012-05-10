module Marchflux
	module Test
		module Fixtures
			class Channels
				def self.build
					['legal', 'food', 'shelter', 'police', 'rally', 'asembly'].each do |channel|
						unless Channel.where(name: channel).first
							puts "   - Channel #{channel} not found. Creating."
							Channel.create(name: channel)
						end
					end					
				end
			end
		end
	end
end
