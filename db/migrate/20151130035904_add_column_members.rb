class AddColumnMembers < ActiveRecord::Migration
  def up
    add_column :members , :phone , :string , :limit =>20
    add_column :members , :company , :string , :limit =>200
    add_column :members , :contect , :string , :limit =>40
    add_column :members , :serial , :integer 
  end

  def end
    remove_column :members , :phone , :string
    remove_column :members , :company , :string
    remove_column :members , :contect , :string
    remove_column :members , :serial , :integer
  end

end
