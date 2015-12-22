class CampaignJob < Struct.new(:campaign_id)

  def perform


    campaign = Campaign.find(campaign_id)
    Delayed::Worker.logger.debug("start campaign for #{campaign.name}")

    Array(1..10000).each do |i|
      Array(1..10000).each do |j|
      end
    end

    Delayed::Worker.logger.debug("#{campaign.name} successfully completed")
    campaign.status = true
    campaign.save
  end

end