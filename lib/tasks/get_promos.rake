namespace :lanacion do
  desc "Get promos from the LaNacion ugly api"
  task get_promos: [:environment] do
    url = "http://23.23.128.233:8080/api/categoria/"
    puts "starting... hold on!"
    Category.find_each do |category|
      puts "working with category #{category.name}"
      response = HTTParty.get(URI.encode(url + category.name))
      body = JSON.parse(response.body)
      puts "I found #{body.size} promos"
      body.each do |promo|
        establecimiento = promo["establecimiento"]
        unless business = Business.where(id: establecimiento["id"]).first
          puts "creating business #{establecimiento["nombre"]}"
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
        
        category.promos.create(
          lanacionid: promo["_id"],
          business: business,
          image: promo["imagen"],
          date_from: promo["desde"],
          date_to: promo["hasta"],
          ptype: promo["beneficio"]["tipo"],
          description: promo["beneficio"]["descripcion"],
          subcategory: promo["beneficio"]["subcategoria"],
          card: promo["beneficio"]["tarjeta"]
        )
      end
    end
    puts "done."
  end
end