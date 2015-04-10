class ApiPromosController < ApplicationController
  def find_by_id
    promo = Promo.where('id = ?', params[:id]).first
    render json: format_promo(promo)
  end

  def find_by_category
    category = Category.where('name = ?', params[:categoria]).first
    promos = Promo.where('category_id = ?', category.id)
    render json: promos.map { |p| format_promo(p) }
  end

  def find_by_location
    render json: Promo.where('id = ?', params[:id])
  end

  private
  def format_promo(promo)
    {
      :_id => promo.id,
      :id => promo.id,
      :point => [promo.business.location_lng,
                 promo.business.location_lat],
      :imagen => "bla",
      :hasta => "bla",
      :desde => "bla",
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
                     :tarjeta => promo.card
                    }
    }
  end
end
