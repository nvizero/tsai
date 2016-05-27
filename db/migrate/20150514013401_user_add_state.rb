class UserAddState < ActiveRecord::Migration

  def up
    add_column :users , :state, :string , :limit => 1
  end

  def down
    remove_column :users , :state
  end
end
