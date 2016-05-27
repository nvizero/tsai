class ProductVerifyState < ActiveRecord::Migration

  def up

    add_column :product_verifies ,:product_verify_state_id ,:integer

  end

  def down
    remove_column :product_verifies ,:product_verify_state_id
  end

end
