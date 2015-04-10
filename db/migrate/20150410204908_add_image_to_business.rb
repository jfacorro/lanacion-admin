class AddImageToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :image, :text
  end
end
