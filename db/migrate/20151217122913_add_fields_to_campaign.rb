class AddFieldsToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :name, :string
    add_column :campaigns, :status, :boolean, :default => false
  end
end