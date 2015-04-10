class ApiPromosController < ApplicationController
  def find_by_id
    promo = Promo.where('id = ?', params[:id]).first
    render json: format_promo(promo)
  end

  def find_by_category
    category = Category.where('name = ?', params[:categoria]).first
    promos = Promo.where('category_id = ? AND ? BETWEEN date_from AND date_to', category.id, Time.now)
    render json: promos.map { |p| format_promo(p) }
  end

  def find_by_location
    distance = (params[:distancia] == nil ? params[:distancia] : 200) / 1000
    lat = params[:latitud].to_f
    lng = params[:longitud].to_f

    delta_lat = (distance / 6378) * (180 / Math::PI);
    delta_lng = (distance / 6378) * (180 / Math::PI) / Math.cos(lat * Math::PI / 180);

    promos = Promo.where('(? BETWEEN date_from AND date_to)', Time.now).business.where('AND (location_lat BETWEEN ? AND ?) AND (location_lng BETWEEN ? AND ?)', lat - delta_lat, lat + delta_lat, lng - delta_lng, lng + delta_lng)
    # location = 'AND (location_lat BETWEEN ? AND ?) AND (location_lng BETWEEN ? AND ?)'
    # bla = lat - delta_lat, lat + delta_lat, lng - delta_lng, lng + delta_lng
    render json: promos.map { |p| format_promo(p) }
  end

  private
  def format_promo(promo)
    {
      :_id => promo.id,
      :id => promo.id,
      :point => [promo.business.location_lng,
                 promo.business.location_lat],
      :imagen => promo.business.image,
      :hasta => promo.date_from,
      :desde => promo.date_to,
      :establecimiento => {:id => promo.business.id,
                           :nombre => promo.business.name,
                           :sucursal => promo.business.branch,
                           :direccion => promo.business.address},
      :beneficio => {:id => promo.id,
                     :tipo => promo.promo_type.name,
                     :nombre => promo.business.name,
                     :description => promo.description,
                     :categoria => promo.category.name,
                     :subcategoria => promo.subcategory.name,
                     :tarjeta => promo.card}
    }
  end
end
