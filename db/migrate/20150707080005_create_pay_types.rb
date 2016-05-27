class CreatePayTypes < ActiveRecord::Migration
  def up

      create_table :pay_types do |t|
          t.string :code
          t.string :content
          t.string :state
          t.integer :create_user_id
          t.integer :modify_user_id
          t.integer :stop_user_id
          t.datetime :stoped_at

          t.timestamps
      end


      add_column :order_by_products , :price ,:integer
      add_column :order_by_products , :total ,:integer

      add_column :product_orders , :order_day   , :date
      add_column :product_orders , :total       , :integer
      add_column :product_orders , :pay_type_id , :integer
      add_column :product_orders , :future_day  , :date
  end

  def down

      remove_column :order_by_products , :price
      remove_column :order_by_products , :total

      remove_column :product_orders , :order_day
      remove_column :product_orders , :total
      remove_column :product_orders , :pay_type_id
      remove_column :product_orders , :future_day

      drop_table :pay_types
  end

end
