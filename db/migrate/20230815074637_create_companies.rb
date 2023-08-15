class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :domain
      t.string :hq_city
      t.string :hq_state
      t.integer :founding_year, null: true
      t.string :hq_zip_code, null: true
      t.string :hq_country, null: true
      t.string :investors, null: true
      t.string :founders, null: true
      t.string :round, null: true
      t.string :raised, null: true
      t.integer :employee_count, null: true

      t.timestamps
    end
  end
end