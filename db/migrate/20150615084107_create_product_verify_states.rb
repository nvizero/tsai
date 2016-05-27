class CreateProductVerifyStates < ActiveRecord::Migration

  def up
    create_table :product_verify_states do |t|
      t.string :title
      t.integer :create_user_id
      t.integer :modify_user_id
      t.integer :stop_user_id
      t.string :state  ,:limit => 2
      t.datetime :stoped_at

      t.timestamps
    end
  end

  def down
    drop_table :product_verify_states
  end

end
