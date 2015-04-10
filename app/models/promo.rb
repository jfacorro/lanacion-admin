class Promo < ActiveRecord::Base
  belongs_to :business
  belongs_to :category
  belongs_to :subcategory
end
