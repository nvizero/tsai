class CreateTrades < ActiveRecord::Migration

  def up
    create_table :trades do |t|
      t.string :description, :limit => 60

      t.timestamps
    end

    change_column :trades, :id, :string,:limit => 60
  end

  def down
    drop_table :trades
  end

end
