class AddColumnOrders < ActiveRecord::Migration[5.2]
  def up
    add_column :orders, :quantity, :integer
    add_column :orders, :price, :integer
    add_column :orders, :trade_no, :integer
    add_column :orders, :customer_name, :string
    add_column :orders, :postal, :string
    add_column :orders, :address, :text
    add_column :orders, :phone, :string
    add_column :orders, :variation, :string
    add_column :orders, :remark, :string
    remove_column :orders, :title, :string
    remove_column :orders, :body, :text
  end
  def down
    remove_column :orders, :quantity, :integer
    remove_column :orders, :price, :integer
    remove_column :orders, :trade_no, :integer
    remove_column :orders, :customer_name, :string
    remove_column :orders, :postal, :string
    remove_column :orders, :address, :text
    remove_column :orders, :phone, :string
    remove_column :orders, :variation, :string
    remove_column :orders, :remark, :string
    add_column :orders, :title, :string
    add_column :orders, :body, :text
  end
end
