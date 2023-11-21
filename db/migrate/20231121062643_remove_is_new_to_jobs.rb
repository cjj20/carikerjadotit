class RemoveIsNewToJobs < ActiveRecord::Migration[7.0]
  def change
    remove_column :jobs, :is_new
  end
end
