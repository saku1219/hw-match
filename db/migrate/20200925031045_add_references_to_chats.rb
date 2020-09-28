class AddReferencesToChats < ActiveRecord::Migration[6.0]
  def change
    add_reference :chats, :user, foreign_key: true
  end
end
