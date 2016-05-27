class ChangeUserPrompt < ActiveRecord::Migration

  def up
    rename_column :users ,:forget_pas , :prompt
  end

  def down
    rename_column :users ,:prompt ,:forget_pas
  end
end
