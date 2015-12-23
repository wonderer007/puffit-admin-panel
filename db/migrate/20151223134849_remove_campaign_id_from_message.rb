class RemoveCampaignIdFromMessage < ActiveRecord::Migration
  def change
    remove_column :messages, :campaign_id
  end
end