Geocoder.configure(
  lookup: :google_places_search,
  api_key: ENV["GOOGLE_MAPS_API_KEY"],
  timeout: 5,
  units: :km,
)