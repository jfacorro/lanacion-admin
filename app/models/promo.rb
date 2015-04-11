class Promo < ActiveRecord::Base
  validates :lanacionid, uniqueness: true

  belongs_to :business
  belongs_to :category

  scope :active, -> { where('? BETWEEN date_from AND date_to', Time.now) }
end
