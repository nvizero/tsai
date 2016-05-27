class AddColumnToDailies < ActiveRecord::Migration

    def up
      add_column :dailies , :state , :string  , :limit =>2
    end

    def down
      remove_column :dailies , :state
    end

end
