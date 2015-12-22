class CampaignsController < ApplicationController

  before_action :authenticate_user!
  before_action :pending_campain, :only => [:new]

  def index
    @campaigns = current_user.campaigns
  end

  def new
    @campaign = Campaign.new
  end

  def create

    campaign = Campaign.new campaign_params
    campaign.user_id = current_user.id
    campaign.save

    Delayed::Job.enqueue(CampaignJob.new(campaign.id))
    flash[:sucess] = "Campaign created sucessfully"
    redirect_to campaigns_path

  end

  private

    def campaign_params
      params.require(:campaign).permit(:name)
    end

    def pending_campain
      redirect_to campaigns_path if Campaign.pending current_user
    end

end