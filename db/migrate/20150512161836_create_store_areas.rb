class CreateStoreAreas < ActiveRecord::Migration
  def change
    create_table :store_areas do |t|
      t.string :area_id, :limit => 8
      t.string :area_name, :limit => 60

      t.timestamps
    end
  end
end
