class CreateUserBelongs < ActiveRecord::Migration

  def up

    create_table :user_belongs do |t|
      t.integer :user_id
      t.integer :belong_user_id
      t.timestamps
    end

    add_column :users ,:vip_access , :string

  end

  def down

    remove_column :users ,:vip_access
    drop_table :user_belongs

  end
end
