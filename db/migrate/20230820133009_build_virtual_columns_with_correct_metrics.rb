class BuildVirtualColumnsWithCorrectMetrics < ActiveRecord::Migration[7.0]
  def change
    def case_statement(metric)
      <<-SQL.strip_heredoc
        CASE
          WHEN entry_period = 'month' THEN (#{metric} * 12)::integer
          WHEN entry_period = 'quarter' THEN (#{metric} * 4)::integer
          ELSE #{metric}::integer
        END
      SQL
    end

    remove_columns :company_entries, :revenue_annualized, :cash_burn_annualized, :gross_profit_annualized, :ebitda_annualized
    
    change_table(:company_entries) do |t|
      t.virtual :revenue_annualized, type: :integer, as: case_statement("revenue"), stored: true
      t.virtual :cash_burn_annualized, type: :integer, as: case_statement("cash_burn"), stored: true
      t.virtual :gross_profit_annualized, type: :integer, as: case_statement("gross_profit"), stored: true
      t.virtual :ebitda_annualized, type: :integer, as: case_statement("ebitda"), stored: true
    end
  end
end
