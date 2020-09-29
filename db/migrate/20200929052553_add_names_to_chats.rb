class AddNamesToChats < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :check, :boolean
  end
end
