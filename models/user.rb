module Marchflux
	# This class stores users-as-datasources.  It is not related to authentication in any way.
	class User
		include Mongoid::Document
		field :name, type: String
		field :service, type: String
		field :id_on_service, type: String
	end
end