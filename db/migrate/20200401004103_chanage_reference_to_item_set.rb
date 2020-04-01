class ChanageReferenceToItemSet < ActiveRecord::Migration[5.2]
  def change
    remove_reference :item_sets, :user, foreign_key: true
    add_reference :item_sets, :company, foreign_key: true
  end
end
