class ChanageReferenceToTaobaoUrl < ActiveRecord::Migration[5.2]
  def change
    remove_reference :taobao_urls, :user, foreign_key: true
    add_reference :taobao_urls, :company, foreign_key: true
  end
end
