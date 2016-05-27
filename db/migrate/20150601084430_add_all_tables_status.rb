class AddAllTablesStatus < ActiveRecord::Migration

  def up
    add_column :accesses ,:state , :string ,:limit => 1
    add_column :products ,:state , :string ,:limit => 1
    add_column :product_verify_types ,:state , :string ,:limit => 1

    add_column :roles ,:state , :string ,:limit => 1
    add_column :store_areas ,:state , :string ,:limit => 1
    add_column :trades ,:state , :string ,:limit => 1

    add_column :verify_type_mains ,:state , :string ,:limit => 1
    rename_column :product_verifies ,:status ,:state

  end

  def down
    rename_column :product_verifies ,:state ,:status
    remove_column :accesses , :state
    remove_column :products , :state
    remove_column :product_verify_types , :state

    remove_column :roles , :state
    remove_column :store_areas ,:state
    remove_column :trades ,:state

    remove_column :verify_type_mains ,:state

  end

end
