class AddCountInCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :count, :integer
  end
end