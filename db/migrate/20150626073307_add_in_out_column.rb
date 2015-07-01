class AddInOutColumn < ActiveRecord::Migration

  def up

    add_column :product_in_outs , :serial , :string
    add_column :product_in_outs , :store_area_id , :string
    add_column :product_in_outs , :level , :string
    add_column :product_in_outs , :save_date , :datetime

  end

  def down

    remove_column :product_in_outs , :serial
    remove_column :product_in_outs , :store_area_id
    remove_column :product_in_outs , :level
    remove_column :product_in_outs , :save_date

  end

end
