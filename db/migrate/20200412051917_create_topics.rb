class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.references :order, foreign_key: true
      t.references :company_company, foreign_key: true
      t.boolean :resolve, default: false, null: false
      t.integer :topic_variety, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
