class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.text :name
      t.float :location_lng
      t.float :location_lat
      t.text :branch
      t.text :address

      t.timestamps
    end
  end
end
