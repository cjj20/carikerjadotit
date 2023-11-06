class Api::V1::JobsController < ApplicationController
  def index
    source = Job

    if params[:salary_is_undisclosed] && params[:salary_is_undisclosed] != ""
      source = source.where(
              salary_is_undisclosed: params[:salary_is_undisclosed],
            )
    end

    if params[:location_type] && params[:location_type] != ""
      source = source.where(
              location_type: params[:location_type]
            )
    end

    if params[:sort_column] && params[:sort_direction] && params[:sort] != "" && params[:sort_direction] != ""
      source = source.order("#{params[:sort_column]} #{params[:sort_direction]}")
    end

    pagination = source.page(params[:page]).per(params[:per_page])

    meta = {
      limit_value: pagination.limit_value,
      total_pages: pagination.total_pages,
      count: source.count,
    }

    data = source.as_json(include: [:company])

    render json: { meta: meta, data: data }
  end
end
