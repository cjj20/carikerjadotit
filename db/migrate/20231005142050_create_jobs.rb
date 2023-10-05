class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.decimal :salary_min
      t.decimal :salary_max
      t.boolean :salary_is_undisclosed
      t.integer :employment_type
      t.integer :location_type
      t.boolean :is_new
      t.integer :experience_level
      t.integer :type_of_work
      t.text :job_description
      t.text :apply_link

      t.timestamps
    end
  end
end
