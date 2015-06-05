class AddProductColumns < ActiveRecord::Migration

  def up

    add_column :products , :code            , :string   , :limit => 10  #編號
    add_column :products , :model_no        , :string   , :limit => 20
    add_column :products , :specification   , :string   , :limit => 20  #規格

    add_column :products , :one_base        , :integer
    add_column :products , :one_heavy1      , :integer
    add_column :products , :one_heavy1_unit , :string   , :limit => 20  #單位
    add_column :products , :one_heavy2      , :integer
    add_column :products , :one_heavy2_unit , :string   , :limit => 20  #單位

    add_column :products , :size           , :integer   #材積
    add_column :products , :size1          , :integer
    add_column :products , :size2          , :integer
    add_column :products , :size3          , :integer

    add_column :products , :item_size      , :integer   #料品尺寸
    add_column :products , :item_size1     , :integer
    add_column :products , :item_size2     , :integer
    add_column :products , :item_size3     , :integer

    add_column :products , :item_subject    , :string   , :limit => 20 #料品科目
    add_column :products , :price_code      , :string   , :limit => 20 #費用代號
    add_column :products , :control         , :string   , :limit => 20 #批號控制


    add_column :products , :serial_code     , :string   , :limit => 20 #圖號
    add_column :products , :version         , :string   , :limit => 20 #版別

    add_column :products , :item_style      , :string   , :limit => 20 #料品分類
    add_column :products , :unit_save       , :string   , :limit => 20 #存貨單位
    add_column :products , :unit_support    , :string   , :limit => 20 #𨍭助單位

    add_column :products , :ratio1          , :string   , :limit => 20 #換算比率1
    add_column :products , :ratio2          , :string   , :limit => 20 #換算比率2

    add_column :products , :create_users_id , :integer    #輸入者
    add_column :products , :modify_users_id , :integer    #修改者

    add_column :products , :party_material  , :string  , :limit => 20 #部位材質
    add_column :products , :is_main         , :string  , :limit => 2 #是否主料




    add_column :products , :category        , :string  , :limit => 20 #產品分類
    add_column :products , :tax             , :string  , :limit => 20 #保稅
    add_column :products , :less_rate       , :string   , :limit => 20 #盤差率
    add_column :products , :adoption        , :string   , :limit => 20 #需先認養
    add_column :products , :form            , :string   , :limit => 50 #料品來源


    add_column :products , :firm            , :string   , :limit => 50 #指定廠商
    add_column :products , :buy_batch       , :string   , :limit => 20 #採購批量
    add_column :products , :lost_rate       , :string   , :limit => 20 #損耗率
    add_column :products , :abcd_category   , :string   , :limit => 20 #ABCD分類
    add_column :products , :schedule        , :string   , :limit => 20 #排程批量
    add_column :products , :business_unit   , :string   , :limit => 20 #營業單位


    add_column :products , :produce_serial  , :string   , :limit => 50 #生產批量
    add_column :products , :buy_unit        , :string   , :limit => 20 #採購單位
    add_column :products , :tariff          , :string   , :limit => 20 #關稅
    add_column :products , :yield_rate      , :string   , :limit => 20 #yield rate
    add_column :products , :packing_way     , :string   , :limit => 20 #領料方式
    add_column :products , :recipientst_serial , :string   , :limit => 20 #領用批量


    add_column :products , :affect_day      , :string   , :limit => 50 #有效天數
    add_column :products , :save_tax_date   , :string   , :limit => 50 #保稅日期
    add_column :products , :head_date       , :string   , :limit => 50 #前置時間
    add_column :products , :buy_way         , :string   , :limit => 50 #請購方式
    add_column :products , :keep_category   , :string   , :limit => 50 #品管類別

    add_column :products , :test_level      , :string   , :limit => 50 #檢驗水準
    add_column :products , :safe_save       , :string   , :limit => 50 #安全存量
    add_column :products , :standard_store_area  , :string   , :limit => 50 #標準庫位
    add_column :products , :virtual         , :string   , :limit => 50 #虛擬件


    add_column :products , :manage_code     , :string   , :limit => 50 #生管代號
    add_column :products , :keep_tax        , :string   , :limit => 50 #保稅帳冊
    add_column :products , :store_code      , :string   , :limit => 50 #倉管代號
    add_column :products , :thing_code      , :string   , :limit => 50 #物管代號
    add_column :products , :income_unit     , :string   , :limit => 50 #最近進價－單位
    add_column :products , :income_number   , :string   , :limit => 50 #最近進價－數字
    add_column :products , :income          , :string   , :limit => 50 #最近進貨

    add_column :products , :check_year      , :integer   #盤點週期－年
    add_column :products , :check_month     , :integer   #盤點週期－月
    add_column :products , :check_day       , :integer   #盤點週期－日
    add_column :products , :alternate_number, :integer   #備用數量





  end




  def down

    remove_column :products , :code
    remove_column :products , :model_no
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

    remove_column :products , :item_subject
    remove_column :products , :price_code
    remove_column :products , :control


    remove_column :products , :serial_code
    remove_column :products , :version

    remove_column :products , :item_style
    remove_column :products , :unit_save
    remove_column :products , :unit_support

    remove_column :products , :ratio1
    remove_column :products , :ratio2

    remove_column :products , :create_users_id
    remove_column :products , :modify_users_id

    remove_column :products , :party_material
    remove_column :products , :is_main




    remove_column :products , :category
    remove_column :products , :tax
    remove_column :products , :less_rate
    remove_column :products , :adoption
    remove_column :products , :form


    remove_column :products , :firm
    remove_column :products , :buy_batch
    remove_column :products , :lost_rate
    remove_column :products , :abcd_category
    remove_column :products , :schedule
    remove_column :products , :business_unit


    remove_column :products , :produce_serial
    remove_column :products , :buy_unit
    remove_column :products , :tariff
    remove_column :products , :yield_rate
    remove_column :products , :packing_way
    remove_column :products , :recipientst_serial


    remove_column :products , :affect_day
    remove_column :products , :save_tax_date
    remove_column :products , :head_date
    remove_column :products , :buy_way
    remove_column :products , :keep_category

    remove_column :products , :test_level
    remove_column :products , :safe_save
    remove_column :products , :standard_store_area
    remove_column :products , :virtual


    remove_column :products , :manage_code
    remove_column :products , :keep_tax
    remove_column :products , :store_code
    remove_column :products , :thing_code
    remove_column :products , :income_unit
    remove_column :products , :income_number
    remove_column :products , :income

    remove_column :products , :check_year
    remove_column :products , :check_month
    remove_column :products , :check_day
    remove_column :products , :alternate_number


  end
end
