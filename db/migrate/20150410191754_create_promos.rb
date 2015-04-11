class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.text :lanacionid
      t.references :business, index: true
      t.references :category, index: true
      t.text :subcategory
      t.text :description
      t.text :card
      t.text :ptype
      t.text :date_from
      t.text :date_to
      t.text :image

      t.timestamps
    end

    add_index :promos, :lanacionid, unique: true
  end
end
