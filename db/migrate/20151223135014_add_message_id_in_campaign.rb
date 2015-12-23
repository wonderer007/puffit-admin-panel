class AddMessageIdInCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :message_id, :integer
  end
end