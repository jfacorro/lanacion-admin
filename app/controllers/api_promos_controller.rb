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
    distance = (params[:distancia].nil? ? params[:distancia] : 200) / 1000
    lat = params[:latitud].to_f
    lng = params[:longitud].to_f

    delta_lat = (distance / 6378) * (180 / Math::PI);
    delta_lng = (distance / 6378) * (180 / Math::PI) / Math.cos(lat * Math::PI / 180);

    promos = Promo.joins(:business)
      .where('(location_lat BETWEEN ? AND ?) AND (location_lng BETWEEN ? AND ?)', lat - delta_lat, lat + delta_lat, lng - delta_lng, lng + delta_lng)
      #.active
    render json: promos.map { |p| format_promo(p) }
  end

  private
  def format_promo(promo)
    {
      :_id => promo.lanacionid,
      :id => promo.id.to_s,
      :point => [promo.business.location_lng,
                 promo.business.location_lat],
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
