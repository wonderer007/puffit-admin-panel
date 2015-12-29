class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login
  has_many :campaigns
  has_many :responses

  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    } # etc.

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def followers
    followers = REDIS.smembers("wonderer007:followers")
  end

  def unread_messages
    self.responses.where(read:false).count
  end

  def messages_count
    self.responses.count
  end

  def campaigns_count
    self.campaigns.count
  end

  def followers_count
    REDIS.smembers("#{self.username}:followers").count
  end

end