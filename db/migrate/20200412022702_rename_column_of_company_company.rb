class RenameColumnOfCompanyCompany < ActiveRecord::Migration[5.2]
  def change
    rename_column :company_companies, :contact_from_id, :contact_from_company_id
    rename_column :company_companies, :contact_to_id, :contact_to_company_id
  end
end
