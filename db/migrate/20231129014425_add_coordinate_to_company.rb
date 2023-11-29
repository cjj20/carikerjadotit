class AddCoordinateToCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :latitude, :string
    add_column :companies, :longitude, :string
  end
end
