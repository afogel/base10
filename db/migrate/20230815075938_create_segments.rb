class CreateSegments < ActiveRecord::Migration[7.0]
  def change
    create_table :segments do |t|
      t.string :name
      t.string :description
      t.belongs_to :industry

      t.timestamps
    end
  end
end
