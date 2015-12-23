class AddTextInCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :msg, :text
  end
end
