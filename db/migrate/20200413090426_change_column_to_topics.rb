class ChangeColumnToTopics < ActiveRecord::Migration[5.2]
  def change
    add_reference :topics, :connect, foreign_key: true
    remove_foreign_key :topics, :company_companies
    remove_reference :topics, :company_company, index: true
  end
end
