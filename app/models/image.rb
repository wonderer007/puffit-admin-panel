class Image < ActiveRecord::Base

  has_one :message, as: :messageable  
  mount_uploader :name, ImageUploader

end