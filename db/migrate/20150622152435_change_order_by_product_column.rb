class ChangeOrderByProductColumn < ActiveRecord::Migration

  def up
    rename_column :order_by_products ,:product_order_id , :code
    change_column :order_by_products ,:code , :string
  end

  def down
    #code
    change_column :order_by_products ,:code , :integer
    rename_column :order_by_products ,:code , :product_order_id
  end
end
