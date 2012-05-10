module Marchflux
	# This class stores users-as-datasources.  It is not related to authentication in any way.
	class Flux
		include Mongoid::Document
		field :service, type: String
		field :user_id, type: String

		field :raw_json, type: String
		
		field :recorded_at, type: String
		field :latitude, type: Float
		field :longitude, type: Float
		field :description, type: String
		field :id_on_service, type: String
	end
end