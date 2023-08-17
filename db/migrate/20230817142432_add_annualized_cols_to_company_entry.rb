class AddAnnualizedColsToCompanyEntry < ActiveRecord::Migration[7.0]
  def change
    case_statement =  <<-SQL.strip_heredoc
      CASE
        WHEN entry_period = 'month' THEN (revenue * 12)::integer
        WHEN entry_period = 'quarter' THEN (revenue * 4)::integer
        ELSE revenue::integer
      END
    SQL
    
    change_table(:company_entries) do |t|
      t.virtual :revenue_annualized, type: :integer, as: case_statement, stored: true
      t.virtual :cash_burn_annualized, type: :integer, as: case_statement, stored: true
      t.virtual :gross_profit_annualized, type: :integer, as: case_statement, stored: true
      t.virtual :ebitda_annualized, type: :integer, as: case_statement, stored: true
    end
  end
end
