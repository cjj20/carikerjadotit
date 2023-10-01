class Company < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[country created_at hq_location id image name updated_at]
  end
end
