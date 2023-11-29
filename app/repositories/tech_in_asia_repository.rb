class TechInAsiaRepository
  require "algolia"

  def create_client
    Algolia::Search::Client.create(ENV["ALGOLIA_APP_ID"], ENV["ALGOLIA_API_KEY"])
  end

  def job_postings(query: "")
    client  = create_client
    index   = client.init_index('job_postings')
    result  = index.search(query, { hitsPerPage: 1000 })
    result[:hits]
  end

  def company_format(data)
    {
      name: data[:company][:name],
      image: data[:company][:avatar],
      country: data[:city][:country_name],
      city: data[:city][:name],
      hq_location: ""
    }
  end

  def job_format(data)
    {
      title: data[:title],
      currency_code: data[:currency][:currency_code],
      salary_min: data[:salary_min],
      salary_max: data[:salary_max],
      salary_is_undisclosed: salary_is_undisclosed_format(data[:is_salary_visible]),
      employment_type: employment_type_format(data[:job_type][:name]),
      location_type: location_type_format(data[:is_remote]),
      experience_level: experience_level_format(max: data[:experience_max]),
      type_of_work: type_of_work_format(data[:job_type][:name]),
      job_description: data[:description],
      apply_link: apply_link_format(data[:external_link], data[:objectID]),
      main_technology: "",
      online_interview: false,
      boosted: data[:is_boosted],
      expires_at: data[:expires_at],
      reference_id: data[:objectID],
      tags: tags_format(data[:job_skills])
    }
  end

  def salary_is_undisclosed_format(is_salary_visible)
    if is_salary_visible == true
      salary_is_undisclosed = false
    else
      salary_is_undisclosed = true
    end

    salary_is_undisclosed
  end

  def employment_type_format(job_type_name)
    if job_type_name == "Permanent"
      employment_type = Job.employment_types[:permanent]
    elsif job_type_name == "Contract"
      employment_type = Job.employment_types[:contract]
    elsif job_type_name == "Freelance"
      employment_type = Job.employment_types[:freelance]
    else
      employment_type = ""
    end

    employment_type
  end

  def location_type_format(is_remote)
    if is_remote == true
      location_type = Job.location_types[:remote]
    else
      location_type = Job.location_types[:office]
    end

    location_type
  end

  def experience_level_format(min: 0, max: 0)
    if max <= 2
      experience_level = Job.experience_levels[:junior]
    elsif max > 5
      experience_level = Job.experience_levels[:senior]
    else
      experience_level = Job.experience_levels[:mid]
    end

    experience_level
  end

  def type_of_work_format(job_type_name)
    if job_type_name == "Full-time"
      type_of_work = Job.type_of_works[:full_time]
    elsif job_type_name == "Part-time"
      type_of_work = Job.type_of_works[:part_time]
    elsif job_type_name == "Internship"
      type_of_work = Job.type_of_works[:internship]
    else
      type_of_work = ""
    end

    type_of_work
  end

  def tags_format(job_skills)
    tags = []
    job_skills.each do |skill|
      tags.push(skill[:name])
    end

    tags
  end

  def apply_link_format(external_link, object_id)
    if external_link
      external_link
    else
      "#{ENV["TECH_IN_ASIA_URL_DETAIL_JOB"]}#{object_id}"
    end
  end
end
