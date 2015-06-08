class AddProductColumns < ActiveRecord::Migration

  def up

    add_column :products , :code            , :string   , :limit => 10  #編號
    add_column :products , :specification   , :string   , :limit => 20  #規格

    add_column :products , :one_base        , :integer  #單箱基數
    add_column :products , :one_heavy1      , :integer
    add_column :products , :one_heavy1_unit , :string   , :limit => 20  #單位

    add_column :products , :one_heavy2      , :integer
    add_column :products , :one_heavy2_unit , :string   , :limit => 20  #單位

    add_column :products , :size           , :string   #材積
    add_column :products , :size1          , :integer
    add_column :products , :size2          , :integer
    add_column :products , :size3          , :integer

    add_column :products , :item_size      , :string   #料品尺寸
    add_column :products , :item_size1     , :integer
    add_column :products , :item_size2     , :integer
    add_column :products , :item_size3     , :integer

    add_column :products , :unit_save       , :string   , :limit => 20 #存貨單位
    add_column :products , :unit_support    , :string   , :limit => 20 #𨍭助單位

    add_column :products , :ratio1          , :integer    #換算比率1
    add_column :products , :ratio2          , :integer   #換算比率2


    add_column :products , :create_user_id , :integer    #輸入者
    add_column :products , :modify_user_id , :integer    #修改者






    add_column :products , :category        , :string  , :limit => 20 #產品分類

    add_column :products , :form            , :string   , :limit => 50 #料品來源
    add_column :products , :buy_batch       , :string   , :limit => 20 #採購批量
    add_column :products , :affect_day      , :string   , :limit => 50 #有效天數
    add_column :products , :head_date       , :string   , :limit => 50 #前置時間

    add_column :products , :safe_save       , :string   , :limit => 50 #安全存量
    add_column :products , :standard_store_area  , :string   , :limit => 50 #標準庫位




    add_column :products , :income_unit     , :string   , :limit => 50 #最近進價－單位
    add_column :products , :income_number   , :integer     #最近進價－數字


  end




  def down

    remove_column :products , :code
    remove_column :products , :specification

    remove_column :products , :one_base
    remove_column :products , :one_heavy1
    remove_column :products , :one_heavy1_unit

    remove_column :products , :one_heavy2
    remove_column :products , :one_heavy2_unit

    remove_column :products , :size
    remove_column :products , :size1
    remove_column :products , :size2
    remove_column :products , :size3

    remove_column :products , :item_size
    remove_column :products , :item_size1
    remove_column :products , :item_size2
    remove_column :products , :item_size3



    remove_column :products , :item_style
    remove_column :products , :unit_save
    remove_column :products , :unit_support

    remove_column :products , :ratio1
    remove_column :products , :ratio2


    remove_column :products , :create_users_id
    remove_column :products , :modify_users_id

    remove_column :products , :category

    remove_column :products , :form
    remove_column :products , :buy_batch
    remove_column :products , :affect_day
    remove_column :products , :head_date

    remove_column :products , :safe_save
    remove_column :products , :standard_store_area

    remove_column :products , :income_unit
    remove_column :products , :income_number

  end
end
