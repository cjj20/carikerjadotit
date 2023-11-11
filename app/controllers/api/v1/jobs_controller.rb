class Api::V1::JobsController < ApplicationController
  def index
    source = Job.all

    if params[:location_type] && params[:location_type] != ""
      source = source.where(
              location_type: params[:location_type]
            )
    end

    if params[:search] && params[:search] != ""
      source = source.where(
        "title ILIKE ? OR main_technology ILIKE ?", params[:search] + "%", params[:search] + "%"
      )
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