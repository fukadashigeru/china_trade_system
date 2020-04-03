class CreateInvitedCompanyUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :invited_company_users do |t|
      t.integer :role
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
