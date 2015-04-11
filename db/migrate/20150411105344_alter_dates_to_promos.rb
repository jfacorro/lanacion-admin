class AlterDatesToPromos < ActiveRecord::Migration
  def change
    change_column :promos, :date_from, "timestamp USING CAST(date_from as timestamp)"
    change_column :promos, :date_to, "timestamp USING CAST(date_from as timestamp)"
  end
end
