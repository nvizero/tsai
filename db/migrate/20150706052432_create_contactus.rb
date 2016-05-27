class CreateContactus < ActiveRecord::Migration
  def up

    create_table :contactus do |t|
      t.string :title
      t.text :content
      t.string :email
      
      t.integer :create_user_id
      t.integer :modify_user_id
      t.integer :stop_user_id
      t.datetime :stoped_at

      t.timestamps
    end


  end



  def down
    drop_table :contactus
  end
end
