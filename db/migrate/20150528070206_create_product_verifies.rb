class CreateProductVerifies < ActiveRecord::Migration
  def up
    create_table :product_verifies do |t|
      t.integer :product_id, :limit=>11
      t.string :status
      t.integer :product_verify_type_id

      t.timestamps
    end
  end


  def down
    drop_table :product_verifies
  end
end
