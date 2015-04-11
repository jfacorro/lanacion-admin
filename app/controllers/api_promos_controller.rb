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
    distance = (params[:distancia].nil? ? 200 : params[:distancia].to_i) / 1000
    promos = Promo.within(distance, origin: [lat, lon]).limit(30)
    # if promos.size < 20
    #   api_promos = Promo.from_api(distance, lat, lon)
    #   promos += api_promos
    # end
    render json: promos.map { |p| format_promo(p) }
  end

  private
  def format_promo(promo)
    {
      :_id => promo.lanacionid,
      :id => promo.id.to_s,
      :point => [promo.lat, promo.lon],
      :imagen => promo.image,
      :desde => promo.date_from,
      :hasta => promo.date_to,
      :establecimiento => {:id => promo.business_id,
                           :nombre => promo.business_name,
                           :sucursal => promo.business_branch,
                           :direccion => promo.business_address},
      :beneficio => {:id => promo.id,
                     :tipo => promo.ptype,
                     :nombre => promo.business_name,
                     :descripcion => promo.description,
                     :categoria => promo.category.name,
                     :subcategoria => promo.subcategory,
                     :tarjeta => promo.card}
    }
  end
end
