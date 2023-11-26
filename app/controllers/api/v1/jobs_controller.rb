module V1
  class Api::V1::JobsController < ApplicationController
    def index
      source = Job.all.order(boosted: :asc)

      if params[:search] && params[:search] != ""
        source = source.search(params[:search]).records
      end

      if params[:location_name] && params[:location_name] != ""
        source = source.joins(:company).where("companies.city ILIKE ?", params[:location_name] + "%")
      end

      if params[:main_technology] && params[:main_technology] != ""
        source = source.where(main_technology: params[:main_technology])
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

      if params[:salary_is_undisclosed] && params[:salary_is_undisclosed] != ""
        source = source.where(
          salary_is_undisclosed: params[:salary_is_undisclosed],
          )
      end

      if params[:sort_column] && params[:sort_direction] && params[:sort] != "" && params[:sort_direction] != ""
        if params[:sort_column] == "salary_max" || params[:sort_column] == "salary_min"
          source = source.where(salary_is_undisclosed: false).order("#{params[:sort_column]} #{params[:sort_direction]}")
        else
          source = source.order("#{params[:sort_column]} #{params[:sort_direction]}")
        end
      end

      pagination = source.page(params[:page]).per(params[:per_page])

      meta = {
        current_page: pagination.current_page,
        limit_value: pagination.limit_value,
        total_pages: pagination.total_pages,
        total_jobs: source.count
      }

      data = source.as_json(include: [:company], methods: [:is_new])

      if source.count == 0
        render json: { meta: meta, data: data }, status: :not_found
      else
        render json: { meta: meta, data: data }, status: :ok
      end
    end
  end
end
