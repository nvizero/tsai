class AddColumnProductInOuts < ActiveRecord::Migration
  def up
    add_column :product_in_outs , :wait_order_id , :integer
    rename_column :wait_orders, :product_in_outs_code, :product_in_out_code
    # wait_orders
    # product_in_outs_code
  end

  def down
    rename_column :wait_orders, :product_in_out_code, :product_in_outs_code
    remove_column :product_in_outs , :wait_order_id
  end
end
