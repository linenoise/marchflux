module Marchflux
	class Hashtag
		include Mongoid::Document
		field :name, type: String
		field :service, type: String
	end
end