class Job < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  Gutentag::ActiveRecord.call self

  enum employment_type: [:permanent, :contract, :freelance]
  enum location_type: [:office, :hybrid, :remote]
  enum experience_level: [:junior, :mid, :senior]
  enum type_of_work: [:full_time, :part_time, :internship]

  belongs_to :company

  def type_of_work
    read_attribute(:type_of_work).titleize if read_attribute(:type_of_work)
  end

  def employment_type
    read_attribute(:employment_type).titleize if read_attribute(:employment_type)
  end

  def is_new
    date_created_at = Time.zone.parse(self.created_at.to_s).to_date
    date_today = Date.today

    date_created_at == date_today
  end
end
