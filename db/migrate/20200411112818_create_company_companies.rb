class CreateCompanyCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :company_companies do |t|
      t.references :contact_from, foreign_key: { to_table: :companies }, null: false
      t.references :contact_to, foreign_key: { to_table: :companies }, null: false
      t.integer :contact_status

      t.timestamps
    end
  end
end
