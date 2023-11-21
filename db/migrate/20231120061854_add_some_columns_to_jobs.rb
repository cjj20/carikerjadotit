class AddSomeColumnsToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :expires_at, :datetime
    add_column :jobs, :boosted, :boolean
    add_column :jobs, :reference_id, :string
  end
end
