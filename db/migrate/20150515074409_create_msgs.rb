class CreateMsgs < ActiveRecord::Migration

  def change

    create_table :msgs do |t|

      t.string :title ,:limit => 100
      t.text :content
      t.string :state ,:limit => 2

      t.timestamps
    end
  end


  def up
    drop_table :msgs
  end
end
