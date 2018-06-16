class AddChatIdToParties < ActiveRecord::Migration[5.1]
  def change
    add_column :parties, :chat_id, :integer
  end
end
