class ChangeStoreAreaPrKey < ActiveRecord::Migration

  def up
      remove_column :store_areas, :id
      change_column :store_areas, :area_id, :primary_key
      change_column :store_areas, :area_id, :string, :limit=>8
      change_column :store_areas, :area_name, :string, :limit=>10
  end


  def down


      execute "ALTER TABLE `store_areas` MODIFY area_id INT NOT NULL;"
      execute "ALTER TABLE `store_areas` DROP PRIMARY KEY;"
      add_column :store_areas, :id, :primary_key
  end
end
