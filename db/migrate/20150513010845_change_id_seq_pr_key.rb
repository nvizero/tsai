class ChangeIdSeqPrKey < ActiveRecord::Migration

  def up

    #ALTER TABLE `id_seqs` CHANGE `pre_id` `pre_id` INT(11) NOT NULL;
    execute "ALTER TABLE `id_seqs` CHANGE `pre_id` `pre_id` INT(11) NOT NULL;"
    #execute "ALTER TABLE `id_seqs` MODIFY pre_id INT NOT NULL;"
    remove_column :id_seqs , :id
    change_column :id_seqs, :pre_id, :primary_key
    change_column :id_seqs, :pre_id, :string, :limit=>7

  end

  def down
    #execute "ALTER TABLE `id_seqs` MODIFY pre_id INT NOT NULL;"
    execute "ALTER TABLE `id_seqs` DROP PRIMARY KEY;"
    add_column :id_seqs, :id, :primary_key
  end

end
