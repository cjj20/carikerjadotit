class Api::V1::JobsController < ApplicationController
  def index
    source = Job.all

    if params[:search] && params[:search] != ""
      source = source.where(
        "title ILIKE ? OR main_technology ILIKE ? OR job_description ILIKE ?",
        params[:search] + "%", params[:search] + "%", params[:search] + "%"
      )
    end

    if params[:location] && params[:location] != ""
      source = source.joins(:company).where("companies.country ILIKE ?", params[:location] + "%")
    end

    if params[:salary_min] && params[:salary_min] != "" && params[:salary_max] && params[:salary_max] != ""
      source = source.where("salary_min >= ? AND salary_max <= ?", params[:salary_min].to_i, params[:salary_max].to_i)
    end

    if params[:experience] && params[:experience] != ""
      array_experience = params[:experience].split(",")
      source = source.where(experience_level: array_experience)
    end

    if params[:employment_type] && params[:employment_type] != ""
      array_employment_type = params[:employment_type].split(",")
      source = source.where(employment_type: array_employment_type)
    end

    if params[:type_of_work] && params[:type_of_work] != ""
      array_type_of_work = params[:type_of_work].split(",")
      source = source.where(type_of_work: array_type_of_work)
    end

    if params[:location_type] && params[:location_type] != ""
      source = source.where(location_type: params[:location_type])
    end

    # all jobs, combined with salary and undisclosed salary
    total_all_jobs = source.count

    if params[:salary_is_undisclosed] && params[:salary_is_undisclosed] != ""
      source = source.where(
        salary_is_undisclosed: params[:salary_is_undisclosed],
        )
    end

    total_undisclosed_salary_jobs = source.count

    if params[:sort_column] && params[:sort_direction] && params[:sort] != "" && params[:sort_direction] != ""
      source = source.order("#{params[:sort_column]} #{params[:sort_direction]}")
    end

    pagination = source.page(params[:page]).per(params[:per_page])

    meta = {
      limit_value: pagination.limit_value,
      total_pages: pagination.total_pages,
      total_undisclosed_salary_jobs: total_undisclosed_salary_jobs,
      total_all_jobs: total_all_jobs
    }

    data = source.as_json(include: [:company])

    render json: { meta: meta, data: data }
  end
end
