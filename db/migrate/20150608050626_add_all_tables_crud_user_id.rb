class AddAllTablesCrudUserId < ActiveRecord::Migration

  def up

    add_column :products , :stop_user_id , :integer
    add_column :products , :stoped_at , :datetime

    add_column :roles , :create_user_id , :integer
    add_column :roles , :modify_user_id , :integer
    add_column :roles , :stop_user_id , :integer

  end

  def down

  end
end
