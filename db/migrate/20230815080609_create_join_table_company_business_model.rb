class CreateJoinTableCompanyBusinessModel < ActiveRecord::Migration[7.0]
  def change
    create_join_table :companies, :business_models do |t|
      t.index [:company_id, :business_model_id], name: 'company_business_model_index'
      t.index [:business_model_id, :company_id], name: 'business_model_company_index'
    end
  end
end
