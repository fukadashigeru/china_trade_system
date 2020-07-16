class Topic < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :connect
  has_many :messages
  enum topic_variety: {contact: 0, order_topic: 1, other: 2}
end
