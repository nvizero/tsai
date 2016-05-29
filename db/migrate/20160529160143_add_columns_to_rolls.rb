class AddColumnsToRolls < ActiveRecord::Migration
  def change
    add_column :rolls, :provider, :string
    add_column :rolls, :uid, :string
  end
end
