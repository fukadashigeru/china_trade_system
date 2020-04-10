class AddUniqueToCompanyUser < ActiveRecord::Migration[5.2]
  def up
    add_index :company_users, [:user_id, :company_id], unique: true, name: 'company_user_unique_index'
    add_index :invited_company_users, [:user_id, :company_id], unique: true, name: 'invited_company_user_unique_index'
  end
  
  def down
    remove_index :company_users, name: 'company_user_unique_index'
    remove_index :invited_company_users, name: 'invited_company_user_unique_index'
  end
end
