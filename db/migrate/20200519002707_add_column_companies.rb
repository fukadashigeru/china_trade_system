class AddColumnCompanies < ActiveRecord::Migration[5.2]
  def up
    remove_column :companies, :is_japanese_retailer_account, :integer
    remove_column :companies, :is_chinese_buyer_account, :integer
    add_column :companies, :account_type, :integer
  end

  def down
    remove_column :companies, :account_type, :integer
    add_column :companies, :is_japanese_retailer_account, :integer, default: 0, null: false
    add_column :companies, :is_chinese_buyer_account, :integer, default: 0, null: false
  end
end
