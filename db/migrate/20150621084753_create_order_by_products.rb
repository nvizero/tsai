class CreateOrderByProducts < ActiveRecord::Migration
  def up
    create_table :order_by_products do |t|

      t.integer :product_id
      t.integer :product_order_id
      t.integer :num

      t.integer :create_user_id
      t.integer :modify_user_id
      t.integer :stop_user_id
      t.datetime :stoped_at

      t.timestamps
    end
  end

  def down
    drop_table :order_by_products
  end
end
