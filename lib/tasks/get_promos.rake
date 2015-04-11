namespace :lanacion do
  desc "Get promos from the LaNacion ugly api"
  task promos_by_category: [:environment] do
    url = "http://23.23.128.233:8080/api/categoria/"
    puts "starting... hold on!"
    Category.find_each do |category|
      puts "working with category #{category.name}"
      process_url(url + category.name)
    end
    puts "done."
  end

  task promos_by_location: [:environment] do
    url = "http://23.23.128.233:8080/api/geo/"
    puts "starting... hold on!"
    200.times do |lat_decimal|
      150.times do |lon_decimal|
        print "."
        process_url(url + "-34.#{600 + lat_decimal}/-58.#{450 + lon_decimal}/1000")
        print "."
        process_url(url + "-34.#{600 + lat_decimal}/-58.#{450 - lon_decimal}/1000")
        print "."
        process_url(url + "-34.#{600 - lat_decimal}/-58.#{450 + lon_decimal}/1000")
        print "."
        process_url(url + "-34.#{600 - lat_decimal}/-58.#{450 - lon_decimal}/1000")
      end
      puts "stats: business -> #{Business.count} - promos -> #{Promo.count}"
    end
    
    puts "done."
  end

  def process_url(url)
    response = HTTParty.get(url)
    body = JSON.parse(response.body)
    # puts "I found #{body.size} promos"
    body.each do |promo|
      establecimiento = promo["establecimiento"]
      unless business = Business.where(id: establecimiento["id"]).first
        # puts "creating business #{establecimiento["nombre"]}"
        lat, lon = promo["point"]
        business = Business.create(
          id: establecimiento["id"],
          name: establecimiento["nombre"],
          branch: establecimiento["sucursal"],
          address: establecimiento["direccion"],
          location_lng: lon,
          location_lat: lat
        )
      end
      
      Promo.create(
        lanacionid: promo["_id"],
        business: business,
        image: promo["imagen"],
        date_from: promo["desde"],
        date_to: promo["hasta"],
        ptype: promo["beneficio"]["tipo"],
        description: promo["beneficio"]["descripcion"],
        subcategory: promo["beneficio"]["subcategoria"],
        card: promo["beneficio"]["tarjeta"],
        category: Category.where(name: promo["beneficio"]["categoria"]).first
      )
    end
  end
end