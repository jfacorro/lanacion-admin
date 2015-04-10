class AddDateFromToPromo < ActiveRecord::Migration
  def change
    add_column :promos, :date_from, :datetime
    add_column :promos, :date_to, :datetime
  end
end
