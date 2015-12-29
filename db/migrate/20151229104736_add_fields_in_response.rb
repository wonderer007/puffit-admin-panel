class AddFieldsInResponse < ActiveRecord::Migration
  def change
    add_column :responses, :message, :text
    add_column :responses, :phone_number, :string
    add_column :responses, :user_id, :integer
    add_column :responses, :read, :boolean , :default => false
  end
end
