class AddCategoryIdToSubcategory < ActiveRecord::Migration
  def change
    add_column :subcategories, :category_id, :serial
  end
end
