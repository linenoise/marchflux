module Marchflux
	class Channel
		include Mongoid::Document
		field :name, type: String
	end
end