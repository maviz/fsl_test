class SerializableUrl < JSONAPI::Serializable::Resource
	type 'urls'

	 attributes :original_url, :short_url, :clicks_count, :created_at

	 has_many :clicks
end