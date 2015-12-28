class ImageUploader < CarrierWave::Uploader::Base
 
  include CarrierWave::MiniMagick
 
  if Rails.env.test? or Rails.env.development?
    storage :file
  else
    storage :fog
  end

 
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
 
  version :large do
    process resize_to_limit: [800, 800]
  end
 
  version :medium, :from_version => :large do
    process resize_to_limit: [500, 500]
  end
 
  version :thumb, :from_version => :medium do
    process resize_to_fit: [100, 100]
  end
 
  version :square do
    process :resize_to_fill => [500, 500]
  end
 
end