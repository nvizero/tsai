class CreateIdSeqs < ActiveRecord::Migration
  def up
    create_table :id_seqs do |t|
      t.string  :pre_id, :limit =>7
      t.string :seq
      t.timestamps
    end
  end


  def down
    drop_table :id_seqs
  end
end
