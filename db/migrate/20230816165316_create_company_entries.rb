class CreateCompanyEntries < ActiveRecord::Migration[7.0]
  def up
    create_enum :entry_period, %w[year quarter month]

    create_table :company_entries do |t|
      t.date :entry_date
      t.enum :entry_period, enum_type: :entry_period, default: 'year'
      t.integer :revenue
      t.integer :cash_burn
      t.integer :gross_profit
      t.decimal :gross_profit_pct
      t.integer :ebitda
      t.integer :cash_on_hand
      t.integer :cac
      t.integer :ltv
      t.integer :arpu
      t.integer :customer_count
      t.date :next_fundraise_at
      t.references :user, null: false, foreign_key: true
      t.references :source, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :company_entries

    execute <<-SQL
      DROP TYPE entry_period;
    SQL
  end
end
