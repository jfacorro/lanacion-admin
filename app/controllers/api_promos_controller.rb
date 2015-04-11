class ApiPromosController < ApplicationController
  def find_by_id
    promo = Promo.find(params[:id])
    render json: format_promo(promo)
  end

  def find_by_category
    category = Category.where(name: params[:categoria]).first
    promos = category.promos #.active
    render json: promos.map { |p| format_promo(p) }
  end

  def find_by_location
    lat = params[:latitud].to_f
    lon = params[:longitud].to_f
    distance = (params[:distancia].nil? ? params[:distancia] : 200) / 1000
    businesses = Business.within(distance, origin: [lat, lon])
    promos = Promo.where(business_id: businesses.collect(&:id)) #.active
    render json: promos.map { |p| format_promo(p) }
  end

  private
  def format_promo(promo)
    {
      :_id => promo.lanacionid,
      :id => promo.id.to_s,
      :point => [promo.business.location_lat,
                 promo.business.location_lng],
      :imagen => promo.image,
      :desde => promo.date_from,
      :hasta => promo.date_to,
      :establecimiento => {:id => promo.business.id,
                           :nombre => promo.business.name,
                           :sucursal => promo.business.branch,
                           :direccion => promo.business.address},
      :beneficio => {:id => promo.id,
                     :tipo => promo.ptype,
                     :nombre => promo.business.name,
                     :descripcion => promo.description,
                     :categoria => promo.category.name,
                     :subcategoria => promo.subcategory,
                     :tarjeta => promo.card}
    }
  end
end
