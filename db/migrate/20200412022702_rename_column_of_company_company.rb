class RenameColumnOfCompanyCompany < ActiveRecord::Migration[5.2]
  def change
    rename_column :company_companies, :contact_from_id, :japanese_retailer_company_id
    rename_column :company_companies, :contact_to_id, :chinese_buyer_company_id
  end
end
