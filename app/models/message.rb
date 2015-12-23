class Message < ActiveRecord::Base
  belongs_to :messageable, polymorphic: true
  has_one :campaign
end