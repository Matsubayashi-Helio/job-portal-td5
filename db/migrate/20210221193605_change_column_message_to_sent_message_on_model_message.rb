class ChangeColumnMessageToSentMessageOnModelMessage < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :message, :sent_message
  end
end
