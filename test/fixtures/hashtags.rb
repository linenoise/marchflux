module Marchflux
	module Test
		module Fixtures
			class Hashtags
				def self.build
					['ows', 'opdx', 'osf', 'occupychiago'].each do |hashtag|
						unless Hashtag.where(name: hashtag).first
							puts "   - Hashtag #{hashtag} not found. Creating."
							Hashtag.create(name: hashtag)
						end
					end					
				end
			end
		end
	end
end
