class Business < ActiveRecord::Base
  validates :id, uniqueness: true
  has_many :promos

  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :location_lat,
                   :lng_column_name => :location_lng
end
