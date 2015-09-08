class Add3ColumnProduct < ActiveRecord::Migration

  def up
    add_column :products , :web_sale_per , :float  , :limit =>10
    add_column :products , :depot_per , :float  , :limit =>10
    add_column :products , :other_per , :float  , :limit =>10
  end

  def down
    remove_column :products , :web_sale_per
    remove_column :products , :depot_per
    remove_column :products , :other_per
  end
end
