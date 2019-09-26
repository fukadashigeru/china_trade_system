class CreateActualItemVarieties < ActiveRecord::Migration[5.2]
  def change
    create_table :actual_item_varieties do |t|
      t.references :order, foreign_key: true
      t.string :item_name

      t.timestamps
    end
  end
end
