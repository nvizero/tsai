class ChangeColumnProduct < ActiveRecord::Migration
  def up
    rename_column :products , :depot_per , :sale_per
  end

  def down
    rename_column :products , :sale_per , :depot_per 
  end
end
