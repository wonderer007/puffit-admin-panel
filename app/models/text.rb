class Text < ActiveRecord::Base
  has_one :message, as: :messageable
end