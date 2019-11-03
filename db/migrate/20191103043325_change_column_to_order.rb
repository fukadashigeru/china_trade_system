class ChangeColumnToOrder < ActiveRecord::Migration[5.2]
  def up
    change_column :orders, :address, :string
    add_column :orders, :item_no, :integer
    add_column :orders, :estimate_charge, :integer
    add_column :orders, :chinese_buyer_status, :integer
    add_column :orders, :chinese_buyer_remark, :string
    add_column :orders, :actual_charge, :integer
    add_column :orders, :commission_fee, :integer
    add_column :orders, :domestic_shipping_fee, :integer
    add_column :orders, :international_shipping_fee, :integer
    add_column :orders, :other_fee, :integer
    add_column :orders, :tracking_number, :integer
  end

  def down
    change_column :orders, :address, :text
    remove_column :orders, :item_no, :integer
    remove_column :orders, :estimate_charge, :integer
    remove_column :orders, :chinese_buyer_status, :integer
    remove_column :orders, :chinese_buyer_remark, :string
    remove_column :orders, :actual_charge, :integer
    remove_column :orders, :commission_fee, :integer
    remove_column :orders, :domestic_shipping_fee, :integer
    remove_column :orders, :international_shipping_fee, :integer
    remove_column :orders, :other_fee, :integer
    remove_column :orders, :tracking_number, :integer
  end
end
