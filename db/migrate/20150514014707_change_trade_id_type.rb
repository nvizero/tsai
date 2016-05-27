class ChangeTradeIdType < ActiveRecord::Migration

  def up
    execute "ALTER TABLE `trades` CHANGE `id` `id` VARCHAR(60) NOT NULL;"
    change_column :trades, :id, :string, :limit=>2
  end

  def down
    execute "ALTER TABLE `trades` DROP PRIMARY KEY;"
    change_column :trades, :id, :string, :limit=>60
  end
end
