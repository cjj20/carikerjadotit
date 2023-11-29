module CompaniesManager
  class SetCoordinate

    attr_accessor :id

    def initialize(id:)
      @id = id
    end

    def call
      company = Company.find(@id)
      company_name = "#{company.name} #{company.city}"
      results = Geocoder.search(company_name)
      # example test/fixtures/files/geocoder/google_places_search.json

      result = results.first
      coordinate = result&.data&.dig("geometry", "location")

      if coordinate
        company.latitude = coordinate["lat"]
        company.longitude = coordinate["lng"]
        company.save!
      end

      company
    end
  end
end


