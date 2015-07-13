class OrderByProductAddColumn < ActiveRecord::Migration

  def up
      add_column :order_by_products , :product_code ,:string
  end

  def down
      remove_column :order_by_products , :product_code
  end

end
