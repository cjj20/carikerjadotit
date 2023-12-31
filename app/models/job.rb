class Job < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  Gutentag::ActiveRecord.call self

  enum employment_type: [:permanent, :contract, :freelance]
  enum location_type: [:office, :hybrid, :remote]
  enum experience_level: [:junior, :mid, :senior]
  enum type_of_work: [:full_time, :part_time, :internship]
  enum currency_format: {
    idr: { code: "IDR", symbol: "Rp", thousand: "rb", million: "jt" },
    sgd: { code: "SGD", symbol: "$", thousand: "k", million: "m" },
  }

  belongs_to :company

  def type_of_work
    read_attribute(:type_of_work).titleize if read_attribute(:type_of_work)
  end

  def employment_type
    read_attribute(:employment_type).titleize if read_attribute(:employment_type)
  end

  def salary_min
    format_salary(read_attribute(:salary_min))
  end

  def salary_max
    format_salary(read_attribute(:salary_max))
  end

  def is_new
    date_created_at = Time.zone.parse(self.created_at.to_s).to_date
    date_today = Date.today

    date_created_at == date_today
  end

  private

    def format_salary(number)
      currency_code = read_attribute(:currency_code).presence&.downcase || "idr"
      currency_format = Job.currency_formats[currency_code]

      if currency_format
        ActiveSupport::NumberHelper
          .number_to_human(number, units: { thousand: currency_format[:thousand], million: currency_format[:million] }, precision: 10)
      else
        number
      end
    end
end
