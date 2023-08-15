class CreateBusinessModels < ActiveRecord::Migration[7.0]
  def change
    create_table :business_models do |t|
      t.string :name

      t.timestamps
    end
  end
end
