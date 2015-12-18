class AddFieldsInChat < ActiveRecord::Migration
  def change

    add_column :chats, :user_id, :integer
    add_column :chats, :phone_number, :string
    add_column :chats, :message, :text

  end
end
