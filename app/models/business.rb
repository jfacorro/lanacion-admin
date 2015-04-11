class Business < ActiveRecord::Base
  validates :id, uniqueness: true
  has_many :promos
end
