class Promo < ActiveRecord::Base
  belongs_to :business
  belongs_to :category
  belongs_to :subcategory
  belongs_to :promo_type
end
