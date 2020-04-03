class RemoveAccountTypeColumnFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :account_type, :integer, null: false
  end
end
