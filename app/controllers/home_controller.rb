class HomeController < ApplicationController
  def index
    @jobs = Job.all.to_json
  end
end
