class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string :title
      t.text :content
      t.integer :num
      t.integer :user_id

      t.timestamps
    end
  end

  def down
    drop_table :products
  end
end
