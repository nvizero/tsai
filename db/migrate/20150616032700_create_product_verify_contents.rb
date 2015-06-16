class CreateProductVerifyContents < ActiveRecord::Migration

  def up

    create_table :product_verify_contents do |t|
      t.string :title
      t.text :content
      t.string :file

      t.string :state  ,:limit => 2

      t.integer :product_verify_id
      t.integer :create_user_id
      t.integer :modify_user_id
      t.integer :stop_user_id
      t.datetime :stoped_at




      t.timestamps
    end
  end


  def down
    drop_table :product_verify_contents
  end

end
