class AddColumnToWaitOrders < ActiveRecord::Migration

  def up
    add_column :wait_orders , :product_name , :string  , :limit =>100
  end

  def down
    remove_column :wait_orders , :product_name
  end


end
