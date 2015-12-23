class Campaign < ActiveRecord::Base

  has_many :delivery_reports  
  belongs_to :message
  belongs_to :user

  def campaigns
    Campaign.where(user_id: self.id).order("created_at DESC")
  end

end