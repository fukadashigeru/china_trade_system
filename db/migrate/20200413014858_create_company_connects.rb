class CreateCompanyConnects < ActiveRecord::Migration[5.2]
  def change
    create_table :company_connects do |t|
      t.references :company, foreign_key: true
      t.references :connect, foreign_key: true

      t.timestamps
    end
  end
end
