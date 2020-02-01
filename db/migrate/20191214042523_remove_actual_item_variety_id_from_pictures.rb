class RemoveActualItemVarietyIdFromPictures < ActiveRecord::Migration[5.2]
  def change
    remove_reference :pictures, :actual_item_variety, foreign_key: true
  end
end
