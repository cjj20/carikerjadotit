module CompaniesManager
  class CreateCompany

    attr_accessor :data

    def initialize(data:)
      @data = data
    end

    def call
      company = Company.find_or_create_by!(
          name: @data[:name],
          image: @data[:image],
          country: @data[:country],
          city: @data[:city],
          hq_location: @data[:hq_location]
        )

      CompaniesManager::SetCoordinate.new(id: company.id).call
    end
  end
end