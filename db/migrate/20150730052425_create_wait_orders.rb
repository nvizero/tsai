class CreateWaitOrders < ActiveRecord::Migration
  def change
    create_table :wait_orders do |t|
      t.integer :product_id
      t.string :code
      t.string :num
      t.string :state
      t.integer :create_user_id
      t.integer :modify_user_id
      t.integer :stop_user_id
      t.date :stoped_at
      t.string :serial
      t.date :save_date

      t.timestamps
    end
  end
end
