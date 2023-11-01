class AddColumnsToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :main_technology, :string
    add_column :jobs, :online_interview, :boolean
    add_column :jobs, :skills, :string
    add_belongs_to :jobs, :company, foreign_key: true
  end
end
