class AddMailToMemeber < ActiveRecord::Migration
  def up
    add_column :members , :email , :string
    add_index :members, :email,                unique: true
  end

  def down
    remove_column :members , :email 
  end
end
