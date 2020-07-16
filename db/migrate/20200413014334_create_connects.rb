class CreateConnects < ActiveRecord::Migration[5.2]
  def change
    create_table :connects do |t|
      t.references :from_company, foreign_key: { to_table: :companies }
      t.references :to_company, foreign_key: { to_table: :companies }
      t.integer :contact_status

      t.timestamps
    end
  end
end
