class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.text :lanacionid
      t.references :category, index: true
      t.float :lat
      t.float :lon
      t.text :subcategory
      t.text :description
      t.text :card
      t.text :ptype
      t.text :date_from
      t.text :date_to
      t.text :image
      t.integer :business_id
      t.text :business_name
      t.text :business_branch
      t.text :business_address

      t.timestamps
    end

    add_index :promos, :lanacionid, unique: true
  end
end
