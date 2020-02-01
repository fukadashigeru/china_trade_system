class CreateTaobaoColorSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :taobao_color_sizes do |t|
      t.string :name

      t.timestamps
    end
  end
end
