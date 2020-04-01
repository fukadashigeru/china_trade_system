class RemoveReferenceUserOfUserOrder < ActiveRecord::Migration[5.2]
  def change
    remove_reference :orders, :japanese_retailer, foreign_key: {to_table: :users}
    remove_reference :orders, :chinese_buyer, foreign_key: {to_table: :users}
  end
end
