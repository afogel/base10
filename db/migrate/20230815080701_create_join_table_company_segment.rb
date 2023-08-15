class CreateJoinTableCompanySegment < ActiveRecord::Migration[7.0]
  def change
    create_join_table :companies, :segments do |t|
      t.index [:company_id, :segment_id]
      t.index [:segment_id, :company_id]
    end
  end
end
