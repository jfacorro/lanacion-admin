class CreatePromoTypes < ActiveRecord::Migration
  def change
    create_table :promo_types do |t|
      t.text :name

      t.timestamps
    end
  end
end
