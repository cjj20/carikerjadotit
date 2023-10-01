class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :image
      t.string :country
      t.string :hq_location

      t.timestamps
    end
  end
end
