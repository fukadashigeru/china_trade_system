class DeleteInvitedCompanyUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :invited_company_users
  end
end
