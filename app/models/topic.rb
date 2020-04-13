class Topic < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :company_company
  has_many :messages
  enum topic_variety: {contact: 0, order_id: 1}
end
