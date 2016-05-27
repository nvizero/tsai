class CreateMembers < ActiveRecord::Migration
  def up
    create_table :members do |t|
      t.string :name
      t.string :tel
      t.string :address
      t.string :state

      t.integer :create_user_id
      t.integer :modify_user_id
      t.integer :stop_user_id
      t.datetime :stoped_at

      t.timestamps
    end
  end


  def down
      drop_table :members
  end
end
