class RenameColumnToOrder < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :variation, :color_size
    rename_column :orders, :remark, :customer_remark
  end
end
