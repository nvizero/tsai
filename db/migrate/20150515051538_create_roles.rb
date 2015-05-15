class CreateRoles < ActiveRecord::Migration
  def up
    create_table :roles do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end

  def down
    drop_table :roles
  end
end
