class CreateInOutTypes < ActiveRecord::Migration
  def up
    create_table :in_out_types do |t|
      t.string :title
      t.string :type


      t.integer :create_user_id
      t.integer :modify_user_id
      t.integer :stop_user_id

      t.datetime :stoped_at
      t.timestamps
    end

    add_column :product_in_outs ,:in_out_type_id ,:integer
    add_column :in_out_types ,:state ,:string
    rename_column :in_out_types ,:type ,:cate

  end


  def down
    rename_column :in_out_types ,:cate ,:type
    remove_column :in_out_types ,:state
    remove_column :product_in_outs , :in_out_type_id
    drop_table :in_out_types
  end

end
