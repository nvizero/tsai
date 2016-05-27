class CreateProductOrders < ActiveRecord::Migration
  def up
    create_table :product_orders do |t|
      t.string :code
      t.string :order_state_id
      t.integer :member_id
      t.string :state

      t.integer :create_user_id
      t.integer :modify_user_id
      t.integer :stop_user_id
      t.datetime :stoped_at

      t.timestamps
    end
  end


  def down
    drop_table :product_orders
  end
end
