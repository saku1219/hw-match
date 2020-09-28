class DropTableChatUsers < ActiveRecord::Migration[6.0]
  def change
    drop_table :chat_users
  end
end
