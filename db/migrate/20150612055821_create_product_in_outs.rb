class CreateProductInOuts < ActiveRecord::Migration
  def up
    create_table :product_in_outs do |t|
      t.integer :product_id
      t.string :code
      t.integer :num
      t.string :in_or_out
      t.string :state , :limit => 2
      t.integer :create_user_id
      t.integer :modify_user_id
      t.integer :stop_user_id
      t.datetime :stoped_at

      t.timestamps
    end
  end


  def down
    drop_table :product_in_outs
  end
end
