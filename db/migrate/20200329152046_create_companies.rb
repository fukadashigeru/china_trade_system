class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.boolean :is_japanese_retailer_account, default: true, null: false
      t.boolean :is_chinese_buyer_account, default: true, null: false

      t.timestamps
    end
  end
end
