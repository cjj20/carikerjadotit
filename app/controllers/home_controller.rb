class HomeController < ApplicationController
  def index
    @jobs = Job.all.to_json(include: [:company])
  end
end
