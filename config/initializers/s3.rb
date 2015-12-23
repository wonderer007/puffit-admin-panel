CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AMAZON_ACCESS_KEY'],
      :aws_secret_access_key  => ENV['AMAZON_SECRET_KEY'],
      :region                 => ENV['AMAZON_REGION'] # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = ENV['AMAZON_BUCKET']
end