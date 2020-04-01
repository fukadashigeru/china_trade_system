class AddOwneUserToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :owner_user, null: false, foreign_key: { to_table: :users }
  end
end
