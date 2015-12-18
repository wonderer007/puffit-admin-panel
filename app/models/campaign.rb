class Campaign < ActiveRecord::Base

  has_many :delivery_reports
  belongs_to :user

  def self.pending user
    Campaign.exists?(user_id: user.id, status:false)
  end

  def campaigns
    Campaign.where(user_id: self.id).order("created_at DESC")
  end

end