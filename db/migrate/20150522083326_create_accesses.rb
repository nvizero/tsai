class CreateAccesses < ActiveRecord::Migration

  def up
    create_table :accesses do |t|
      t.string :title
      t.string :code

      t.timestamps
    end
  end

  def down
    
    drop_table :accesses

  end
end
