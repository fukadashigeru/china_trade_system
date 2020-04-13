class DropCompanyCompanies < ActiveRecord::Migration[5.2]
  def up
    drop_table :company_companies
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
