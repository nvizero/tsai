class CreateOrderStates < ActiveRecord::Migration
  def up
    create_table :order_states do |t|
      t.string :title
      t.string :state

      t.integer :create_user_id
      t.integer :modify_user_id
      t.integer :stop_user_id
      t.datetime :stoped_at

      t.timestamps
    end
  end

  def down
    drop_table :order_states
  end

end
