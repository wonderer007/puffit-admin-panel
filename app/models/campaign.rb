class Campaign < ActiveRecord::Base
  has_many :delivery_reports
end