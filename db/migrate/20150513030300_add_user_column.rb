class AddUserColumn < ActiveRecord::Migration

  def up
    add_column :users ,:role_id, :integer, :limit=>2
    add_column :users ,:name, :string, :limit=>60
    add_column :users ,:boss, :string, :limit=>20
    add_column :users ,:serial_code, :string, :limit=>20
    add_column :users ,:tel, :string, :limit=>20

    add_column :users ,:company_address, :string, :limit=>80
    add_column :users ,:send_address, :string, :limit=>80
    add_column :users ,:check_date, :string, :limit=>45
    add_column :users ,:password, :string, :limit=>255
    add_column :users ,:re_password, :string, :limit=>255

    add_column :users ,:forget_pas, :string, :limit=>100
    add_column :users ,:text, :text
    add_column :users ,:trade_id, :string, :limit=>2
    add_column :users ,:store_area_id, :string, :limit=>8

    remove_column :users, :address
  end

  def down
    add_column :users ,:address, :string

    remove_column :users, :role_id
    remove_column :users ,:name
    remove_column :users ,:boss
    remove_column :users ,:serial_code
    remove_column :users ,:tel

    remove_column :users ,:company_address
    remove_column :users ,:send_address
    remove_column :users ,:check_date
    remove_column :users ,:password
    remove_column :users ,:re_password

    remove_column :users ,:forget_pas
    remove_column :users ,:text
    remove_column :users ,:trade_id
    remove_column :users ,:store_area_id

  end

end
