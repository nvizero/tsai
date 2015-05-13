class AddUserColumn < ActiveRecord::Migration

  def up
    add_column :users ,:role_id, :integer, :limit=>2
  end

  def down
    remove_column :users, :role_id
    
  end

end
