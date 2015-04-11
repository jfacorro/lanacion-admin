class ApnsToken < ActiveRecord::Base
  validates :device_id, uniqueness: true
end