class AddCurrencyCodeToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :currency_code, :string
  end
end
