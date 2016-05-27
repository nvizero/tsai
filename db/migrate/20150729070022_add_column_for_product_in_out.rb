class AddColumnForProductInOut < ActiveRecord::Migration
  # def change
  # end

  def up
    add_column :product_in_outs , :is_finish , :string , :limit =>2
  end

  def down
    remove_column :product_in_outs , :is_finish
  end

end
