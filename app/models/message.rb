class Message < ApplicationRecord
  belongs_to :topic
  belongs_to :company_user
end
