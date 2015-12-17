class AddEndDateTimeInCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :end_time, :datetime
  end
end