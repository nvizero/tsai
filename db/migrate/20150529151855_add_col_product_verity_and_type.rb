class AddColProductVerityAndType < ActiveRecord::Migration

  def up
    add_column :product_verify_types ,:type ,:integer, :limit => 2
    add_column :product_verify_types , :type_name ,:string, :limit => 30
    add_column :product_verifies , :type ,:integer, :limit => 2
    add_column :product_verifies , :type_name ,:string, :limit => 30
  end

  def down
    remove_column :product_verify_types , :type
    remove_column :product_verify_types , :type_name
    remove_column :product_verifies , :type
    remove_column :product_verifies , :type_name
  end
end
