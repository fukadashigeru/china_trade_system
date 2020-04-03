class ChangeColumnToCompanyAboutNullFalse < ActiveRecord::Migration[5.2]
  def up
    remove_column :companies, :is_japanese_retailer_account
    remove_column :companies, :is_chinese_buyer_account
    add_column :companies, :is_japanese_retailer_account, :integer, null: false, default: 0
    add_column :companies, :is_chinese_buyer_account, :integer, null: false, default: 0
  end

  def down
    remove_column :companies, :is_japanese_retailer_account
    remove_column :companies, :is_chinese_buyer_account
    add_column :companies, :is_japanese_retailer_account, :boolean, null: false, default: true
    add_column :companies, :is_chinese_buyer_account, :boolean, null: false, default: true
  end
end
