class CreateProductVerifyTypes < ActiveRecord::Migration
  def up
    create_table :product_verify_types do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end

  def down
    drop_table :product_verify_types
  end

end
