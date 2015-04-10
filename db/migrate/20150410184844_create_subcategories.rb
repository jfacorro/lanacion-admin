class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.text :name

      t.timestamps
    end
  end
end
