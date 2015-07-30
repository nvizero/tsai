class ChangeWaitOrder < ActiveRecord::Migration

  def up

    add_column :wait_orders , :product_order_code , :string ,:limit =>100
    add_column :wait_orders , :product_in_outs_code , :string ,:limit =>100
    add_column :wait_orders , :price , :integer
    add_column :wait_orders , :total , :integer
    remove_column :wait_orders,  :save_date

  end

  def down

    add_column :wait_orders , :save_date , :date
    remove_column :wait_orders , :product_order_code
    remove_column :wait_orders , :product_in_outs_code
    remove_column :wait_orders , :price
    remove_column :wait_orders , :total

  end
  
end
