namespace :lanacion do
  desc "Get promos from the LaNacion ugly api"
  task promos_by_categories: [:environment] do
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
        process_url(url + "-34.#{580 + lat_decimal}/-58.#{408 + lon_decimal}/1000")
        print "."
        process_url(url + "-34.#{580 + lat_decimal}/-58.#{408 - lon_decimal}/1000")
        print "."
        process_url(url + "-34.#{580 - lat_decimal}/-58.#{408 + lon_decimal}/1000")
        print "."
        process_url(url + "-34.#{580 - lat_decimal}/-58.#{408 - lon_decimal}/1000")
      end
      puts "stats: promos -> #{Promo.count}"
    end
    
    puts "done."
  end

  def process_url(url)
    response = HTTParty.get(URI.escape(url))
    body = JSON.parse(response.body)
    body.each do |promo|
      establecimiento = promo["establecimiento"]
      lat, lon = promo["point"]
      e = Promo.create(
        lanacionid: promo["id"],
        lat: lat.to_f,
        lon: lon.to_f,
        image: promo["imagen"],
        date_from: promo["desde"],
        date_to: promo["hasta"],
        ptype: promo["beneficio"]["tipo"],
        description: promo["beneficio"]["descripcion"],
        subcategory: promo["beneficio"]["subcategoria"],
        card: promo["beneficio"]["tarjeta"],
        business_id: establecimiento["id"],
        business_name: establecimiento["nombre"],
        business_branch: establecimiento["sucursal"],
        business_address: establecimiento["direccion"],
        category: Category.where(name: promo["beneficio"]["categoria"]).first
      )

      unless e.errors.to_a.empty?
        puts "e.errors -> #{e.errors.to_a}"
      end
    end
  end
end