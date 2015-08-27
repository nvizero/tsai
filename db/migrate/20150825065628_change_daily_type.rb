class ChangeDailyType < ActiveRecord::Migration
  def up
    rename_column :dailies, :type , :day_type
  end

  def down
    rename_column :dailies, :day_type , :type
  end
end
