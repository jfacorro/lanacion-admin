class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.integer :business_id
      t.text :description
      t.integer :category_id
      t.integer :subcategory_id
      t.text :card
      t.integer :promo_type_id

      t.timestamps
    end
  end
end
