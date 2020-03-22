class AddReferenceToItemUnit < ActiveRecord::Migration[5.2]
  def change
    add_reference :item_units, :item_set, foreign_key: true
  end
end
