class CreateDailies < ActiveRecord::Migration

  def up
      create_table :dailies do |t|
        t.date :day
        t.string :type
        t.string :title
        t.text :content
        t.integer :created_user_id
        t.integer :modify_user_id
        t.datetime :stoped_at
        t.integer :stop_user_id
        t.timestamps
      end
  end



  def down
    drop_table :dailies
  end


end
