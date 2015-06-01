class AddProductAndVerifyTypes < ActiveRecord::Migration

  def up
    add_column :product_verify_types , :verify_type_main_id, :integer, :limit =>2
    add_column :products , :verify_type_main_id, :integer, :limit =>2

  end

  def down
    remove_column :product_verify_types , :verify_type_main_id
    remove_column :products , :verify_type_main_id
  end
end
