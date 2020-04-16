class ActualItemUnit < ApplicationRecord
  belongs_to :item_unit
  belongs_to :order
end
