class AddAllTablesCrudUserId < ActiveRecord::Migration

  def up

    add_column :products , :stop_user_id , :integer
    add_column :products , :stoped_at , :datetime

    add_column :roles , :create_user_id , :integer
    add_column :roles , :modify_user_id , :integer
    add_column :roles , :stop_user_id , :integer
    add_column :roles , :stoped_at , :datetime

    add_column :verify_type_mains , :create_user_id , :integer
    add_column :verify_type_mains , :modify_user_id , :integer
    add_column :verify_type_mains , :stop_user_id , :integer
    add_column :verify_type_mains , :stoped_at , :datetime

    add_column :trades , :create_user_id , :integer
    add_column :trades , :modify_user_id , :integer
    add_column :trades , :stop_user_id , :integer
    add_column :trades , :stoped_at , :datetime

    add_column :store_areas , :create_user_id , :integer
    add_column :store_areas , :modify_user_id , :integer
    add_column :store_areas , :stop_user_id , :integer
    add_column :store_areas , :stoped_at , :datetime

    add_column :product_verify_types , :create_user_id , :integer
    add_column :product_verify_types , :modify_user_id , :integer
    add_column :product_verify_types , :stop_user_id , :integer
    add_column :product_verify_types , :stoped_at , :datetime

    add_column :product_verifies , :create_user_id , :integer
    add_column :product_verifies , :modify_user_id , :integer
    add_column :product_verifies , :stop_user_id , :integer
    add_column :product_verifies , :stoped_at , :datetime

    add_column :msgs , :create_user_id , :integer
    add_column :msgs , :modify_user_id , :integer
    add_column :msgs , :stop_user_id , :integer
    add_column :msgs , :stoped_at , :datetime

    add_column :id_seqs , :create_user_id , :integer
    add_column :id_seqs , :modify_user_id , :integer
    add_column :id_seqs , :stop_user_id , :integer
    add_column :id_seqs , :stoped_at , :datetime

    add_column :accesses , :create_user_id , :integer
    add_column :accesses , :modify_user_id , :integer
    add_column :accesses , :stop_user_id , :integer
    add_column :accesses , :stoped_at , :datetime

  end

  def down

    remove_column :products , :stop_user_id , :integer
    remove_column :products , :stoped_at , :datetime

    remove_column :roles , :create_user_id , :integer
    remove_column :roles , :modify_user_id , :integer
    remove_column :roles , :stop_user_id , :integer
    remove_column :roles , :stoped_at , :datetime

    remove_column :verify_type_mains , :create_user_id , :integer
    remove_column :verify_type_mains , :modify_user_id , :integer
    remove_column :verify_type_mains , :stop_user_id , :integer
    remove_column :verify_type_mains , :stoped_at , :datetime

    remove_column :trades , :create_user_id , :integer
    remove_column :trades , :modify_user_id , :integer
    remove_column :trades , :stop_user_id , :integer
    remove_column :trades , :stoped_at , :datetime

    remove_column :store_areas , :create_user_id , :integer
    remove_column :store_areas , :modify_user_id , :integer
    remove_column :store_areas , :stop_user_id , :integer
    remove_column :store_areas , :stoped_at , :datetime

    remove_column :product_verify_types , :create_user_id , :integer
    remove_column :product_verify_types , :modify_user_id , :integer
    remove_column :product_verify_types , :stop_user_id , :integer
    remove_column :product_verify_types , :stoped_at , :datetime

    remove_column :product_verifies , :create_user_id , :integer
    remove_column :product_verifies , :modify_user_id , :integer
    remove_column :product_verifies , :stop_user_id , :integer
    remove_column :product_verifies , :stoped_at , :datetime

    remove_column :msgs , :create_user_id , :integer
    remove_column :msgs , :modify_user_id , :integer
    remove_column :msgs , :stop_user_id , :integer
    remove_column :msgs , :stoped_at , :datetime

    remove_column :id_seqs , :create_user_id , :integer
    remove_column :id_seqs , :modify_user_id , :integer
    remove_column :id_seqs , :stop_user_id , :integer
    remove_column :id_seqs , :stoped_at , :datetime

    remove_column :accesses , :create_user_id , :integer
    remove_column :accesses , :modify_user_id , :integer
    remove_column :accesses , :stop_user_id , :integer
    remove_column :accesses , :stoped_at , :datetime

  end
end
