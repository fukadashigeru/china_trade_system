class AddOrderRefToPicture < ActiveRecord::Migration[5.2]
  def change
    add_reference :pictures, :order, foreign_key: true
  end
end
