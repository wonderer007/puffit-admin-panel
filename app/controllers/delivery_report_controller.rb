class DeliveryReportController < ApplicationController

  before_action :set_campaign

  def index
    @delivery_reports = @campaign.delivery_reports
  end

  private

    def set_campaign
      @campaign = Campaign.find params[:campaign_id]
    end

end