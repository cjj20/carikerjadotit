class Job < ApplicationRecord
  enum employment_type: [:permanent, :contract, :freelance]
  enum location_type: [:office, :hybrid, :remote]
  enum experience_level: [:junior, :mid, :senior]
  enum type_of_work: [:full_time, :part_time, :internship]

  def type_of_work
    read_attribute(:type_of_work).titleize
  end
end
