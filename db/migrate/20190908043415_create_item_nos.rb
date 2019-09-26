class CreateItemNos < ActiveRecord::Migration[5.2]
  def change
    create_table :item_nos do |t|
      t.references :user, foreign_key: true
      t.integer :item_no
      t.string :item_name

      t.timestamps
    end
  end
end
