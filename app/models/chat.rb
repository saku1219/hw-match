class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :work
  has_many   :messages
end
