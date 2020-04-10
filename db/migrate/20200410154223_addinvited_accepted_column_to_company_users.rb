class AddinvitedAcceptedColumnToCompanyUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :company_users, :invited_accepted, :boolean, null: false, default: false
  end

  def down
    remove_column :company_users, :invited_accepted, :boolean
  end
end
