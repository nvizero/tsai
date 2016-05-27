class AddUserUsername < ActiveRecord::Migration

  def up
    add_column :users ,:username ,:string, :limit=>100
  end

  def down
    remove_column :users ,:username
  end

end
