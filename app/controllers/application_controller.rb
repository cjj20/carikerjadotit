class ApplicationController < ActionController::Base
  before_action :say_beep, if: -> { is_dev }

  def is_dev
    ENV['RAILS_ENV'] == 'development'
  end

  def say_beep
    print "\a"
  end
end
