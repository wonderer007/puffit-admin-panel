class AddCampaignIdInMessage < ActiveRecord::Migration
  def change
    add_column :messages, :campaign_id, :integer
  end
end
