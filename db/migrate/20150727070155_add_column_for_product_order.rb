class AddColumnForProductOrder < ActiveRecord::Migration

  def up
    add_column :product_orders , :confirm_order , :string , :limit =>2
  end

  def down
    remove_column :product_orders , :confirm_order
  end

end
