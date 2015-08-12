class AddProductInOutColumn < ActiveRecord::Migration
  def up
    add_column :product_in_outs , :in_come_check , :string , :limit=>2
  end

  def down
    remove_column :product_in_outs , :in_come_check
  end
end
