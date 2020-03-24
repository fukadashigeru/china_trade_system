class AddFirstCandidateColumnToItemUnit < ActiveRecord::Migration[5.2]
  def change
    add_reference :item_units, :first_candidate, foreign_key: { to_table: :taobao_urls }
  end
end
