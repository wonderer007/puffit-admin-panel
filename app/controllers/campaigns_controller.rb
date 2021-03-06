class CampaignsController < ApplicationController

  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: CampaignsDatatable.new(view_context) }
    end
  end

  def new
    @campaign = Campaign.new
  end

  def create

    if params[:campaign][:type].to_i == 1
      text = Text.create(msg: params[:campaign][:text])
      id  = text.id
      type = text.class.name
    else
      image = Image.create(name: params[:campaign][:avatar])
      id  = image.id
      type = image.class.name
    end

    message   = Message.create(messageable_id: id, messageable_type: type)
    campaign  = Campaign.new campaign_params
    campaign.user_id = current_user.id
    campaign.message = message

    campaign.save

    Delayed::Job.enqueue(CampaignJob.new(campaign.id))
    flash[:sucess] = "Campaign created sucessfully"
    redirect_to campaigns_path

  end

  def show
    @campaign = current_user.campaigns.find params[:id]
  end

  private

    def campaign_params
      params.require(:campaign).permit(:name)
    end

end