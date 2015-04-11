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

  def self.from_api(distance, lat, lon)
    url = "http://23.23.128.233:8080/api/geo/#{lat}/#{lon}/#{distance}"
    response = HTTParty.get(URI.escape(url))
    body = JSON.parse(response.body)
    promos = []
    body.each do |promo_from_api|
      establecimiento = promo_from_api["establecimiento"]
      lat, lon = promo_from_api["point"]
      promo = Promo.find_or_create(
        lanacionid: promo_from_api["id"],
        lat: lat.to_f,
        lon: lon.to_f,
        image: promo_from_api["imagen"],
        date_from: promo_from_api["desde"],
        date_to: promo_from_api["hasta"],
        ptype: promo_from_api["beneficio"]["tipo"],
        description: promo_from_api["beneficio"]["descripcion"],
        subcategory: promo_from_api["beneficio"]["subcategoria"],
        card: promo_from_api["beneficio"]["tarjeta"],
        business_id: establecimiento["id"],
        business_name: establecimiento["nombre"],
        business_branch: establecimiento["sucursal"],
        business_address: establecimiento["direccion"],
        category: Category.where(name: promo_from_api["beneficio"]["categoria"]).first
      )
      
      promos << promo
    end
    
    promos
  end
end
