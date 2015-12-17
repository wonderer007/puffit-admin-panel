class AddFieldsToDeliveryReport < ActiveRecord::Migration
  def change
    add_column :delivery_reports, :campaign_id, :integer
    add_column :delivery_reports, :phone_number, :string
    add_column :delivery_reports, :status, :boolean, :default => false    
  end
end