class AddColumnUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :name, :string, null: false
    add_column :users, :account_type, :integer, null: false
  end
  def down
    remove_column :users, :name, :string, null: false
    remove_column :users, :account_type, :integer, null: false
  end
end
