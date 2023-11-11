class RemoveSkillsFromJobs < ActiveRecord::Migration[7.0]
  def change
    remove_column :jobs, :skills
  end
end
