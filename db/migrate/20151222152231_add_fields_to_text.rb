class AddFieldsToText < ActiveRecord::Migration
  def change
    add_column :texts, :msg, :text
  end
end
