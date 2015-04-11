class Promo < ActiveRecord::Base
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lon

  validates :lanacionid, uniqueness: true

  belongs_to :business
  belongs_to :category

  scope :active, -> { where('? BETWEEN date_from AND date_to', Time.now) }
end
