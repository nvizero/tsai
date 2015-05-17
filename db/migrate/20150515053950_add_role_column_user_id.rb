class AddRoleColumnUserId < ActiveRecord::Migration

  def up
    add_column    :roles , :user_id , :integer , :limit => 11
  end

  def down
    remove_column :roles , :user_id , :integer
  end
end
