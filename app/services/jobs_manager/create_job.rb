module JobsManager
  class CreateJob

    attr_accessor :data, :company

    def initialize(data:, company:)
      @data = data
      @company = company
    end

    def call
      new_job = Job.find_or_create_by!(
        title: @data[:title],
        currency_code: @data[:currency_code],
        salary_min: @data[:salary_min],
        salary_max: @data[:salary_max],
        salary_is_undisclosed: @data[:salary_is_undisclosed],
        employment_type: @data[:employment_type],
        location_type: @data[:location_type],
        experience_level: @data[:experience_level],
        type_of_work: @data[:type_of_work],
        job_description: @data[:job_description],
        apply_link: @data[:apply_link],
        main_technology: @data[:main_technology],
        online_interview: @data[:online_interview],
        boosted: @data[:boosted],
        expires_at: @data[:expires_at],
        reference_id: @data[:reference_id],
        company_id: @company.id
      )

      new_job.tag_names += @data[:tags]
      new_job.save
    end
  end
end
