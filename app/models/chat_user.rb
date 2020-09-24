class ChatUser < ApplicationRecord
  belongs_to :user
  belongs_to :work
  belongs_to :chat
end
