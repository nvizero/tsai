class AddRoleColunm < ActiveRecord::Migration

  def up
      add_column :roles , :main ,:string ,:limit =>40
      add_column :roles , :code ,:string ,:limit =>50
  end

  def down
    remove_column :roles , :main
    remove_column :roles , :code 
  end

end
