class AddMsgsColumn < ActiveRecord::Migration

  def up
    add_column :msgs ,:place ,:string ,:limit=>50
  end

  def down
    remove_column :msgs ,:place 
  end

end
