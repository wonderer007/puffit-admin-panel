class DeliveryReportController < ApplicationController

  before_action :authenticate_user!
  before_action :set_campaign

  def index

    respond_to do |format|
      format.html
      format.json { render json: DeliveryReportsDatatable.new(view_context, @campaign) }
    end

  end

  private

    def set_campaign
      @campaign = Campaign.find params[:campaign_id]
    end

end