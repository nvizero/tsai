User.create!( :username => "admin123", :role_id=> 1 ,:re_password => 'admin123',
              :name =>'admin', :state=>'Y' ,:password=>'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918' ,
              :email =>"nvizero@yahoo.com.tw" , :prompt=>'admin123')

User.create!( :username => "nvizero", :role_id=> 1 ,:re_password => 'nvizero',
              :name =>'nvizero', :state=>'Y' ,:password=>'5836606da0b5639f4e0fb03747c5ef7a9821425dc1002d641f743aca8488487e' ,
              :email =>"withvictor@gmail.com" , :prompt=>'nvizero')


Msg.create!( :title => "關於我們", :content => '關於我們＿' , :state=>'Y' , :place=>'top')
Msg.create!( :title => "服務項目", :content => '服務項目＿' , :state=>'Y' , :place=>'top')
Msg.create!( :title => "三證說明", :content => '三證說明＿' , :state=>'Y' , :place=>'top')

VerifyTypeMain.create!( :title => "食品", :content => '' , :state=>'Y' )
VerifyTypeMain.create!( :title => "化裝品", :content => '' , :state=>'Y')



Access.create!(:title => '三檔類型主檔－首頁', :code=>'verify_type_mains/index' , :state =>'Y')
Access.create!(:title => '三檔類型主檔－新增', :code=>'verify_type_mains/new'   , :state =>'Y')
Access.create!(:title => '三檔類型主檔－編輯', :code=>'verify_type_mains/edit'  , :state =>'Y')
Access.create!(:title => '三檔類型主檔－删除', :code=>'verify_type_mains/del'   , :state =>'Y')

Access.create!(:title => '會員－首頁',   :code=>'users/index' , :state =>'Y')
Access.create!(:title => '會員－新增',   :code=>'users/new'   , :state =>'Y')
Access.create!(:title => '會員－編輯',   :code=>'users/edit'  , :state =>'Y')
Access.create!(:title => '會員－删除',   :code=>'users/del'   , :state =>'Y')

Access.create!(:title => '會員－EXCEL', :code=>'users/excel'   , :state =>'Y')
Access.create!(:title => '會員－修改密碼', :code=>'users/edit_password'   , :state =>'Y')


Access.create!(:title => '顧客－首頁',   :code=>'members/index' , :state =>'Y')
Access.create!(:title => '顧客－新增',   :code=>'members/new'   , :state =>'Y')
Access.create!(:title => '顧客－編輯',   :code=>'members/edit'  , :state =>'Y')
Access.create!(:title => '顧客－删除',   :code=>'members/del'   , :state =>'Y')


Access.create!(:title => '角色－首頁', :code=>'roles/index' , :state =>'Y')
Access.create!(:title => '角色－新增', :code=>'roles/new'   , :state =>'Y')
Access.create!(:title => '角色－編輯', :code=>'roles/edit'  , :state =>'Y')
Access.create!(:title => '角色－删除', :code=>'roles/del'   , :state =>'Y')

Access.create!(:title => '交易碼－首頁', :code=>'trades/index' , :state =>'Y')
Access.create!(:title => '交易碼－新增', :code=>'trades/new'   , :state =>'Y')
Access.create!(:title => '交易碼－編輯', :code=>'trades/edit'  , :state =>'Y')
Access.create!(:title => '交易碼－删除', :code=>'trades/del'   , :state =>'Y')

Access.create!(:title => '庫位－首頁', :code=>'store_areas/index' , :state =>'Y')
Access.create!(:title => '庫位－新增', :code=>'store_areas/new'   , :state =>'Y')
Access.create!(:title => '庫位－編輯', :code=>'store_areas/edit'  , :state =>'Y')
Access.create!(:title => '庫位－删除', :code=>'store_areas/del'   , :state =>'Y')

Access.create!(:title => '權限－首頁', :code=>'accesses/index' , :state =>'Y')
Access.create!(:title => '權限－新增', :code=>'accesses/new'   , :state =>'Y')
Access.create!(:title => '權限－編輯', :code=>'accesses/edit'  , :state =>'Y')
Access.create!(:title => '權限－删除', :code=>'accesses/del'   , :state =>'Y')




Access.create!(:title => '三檔類型－首頁', :code=>'product_verify_types/index' , :state =>'Y')
Access.create!(:title => '三檔類型－新增', :code=>'product_verify_types/new'   , :state =>'Y')
Access.create!(:title => '三檔類型－編輯', :code=>'product_verify_types/edit'  , :state =>'Y')
Access.create!(:title => '三檔類型－删除', :code=>'product_verify_types/del'   , :state =>'Y')

Access.create!(:title => '商品管理－首頁', :code=>'products/index' , :state =>'Y'  )
Access.create!(:title => '商品管理－新增', :code=>'products/new'   , :state =>'Y'  )
Access.create!(:title => '商品管理－編輯', :code=>'products/edit'  , :state =>'Y'  )
Access.create!(:title => '商品管理－删除', :code=>'products/del'   , :state =>'Y'  )
Access.create!(:title => '商品管理－三證進度', :code=>'watch_verify' , :state =>'Y' )
Access.create!(:title => '商品管理－辦理三證', :code=>'do_3_verify' , :state =>'Y'  )

# 商品庫存查詢
Access.create!(:title => '商品管理－辦理三證', :code=>'do_3_verify' , :state =>'Y'  )
Access.create!(:title => '商品管理－辦理三證', :code=>'do_3_verify' , :state =>'Y'  )
Access.create!(:title => '商品管理－辦理三證', :code=>'do_3_verify' , :state =>'Y'  )


Access.create!(:title => '辦證進度查詢－首頁', :code=>'product_verifies/index' , :state =>'Y')
Access.create!(:title => '辦證進度查詢－新增', :code=>'product_verifies/new'   , :state =>'Y')
Access.create!(:title => '辦證進度查詢－編輯', :code=>'product_verifies/edit'  , :state =>'Y')
Access.create!(:title => '辦證進度查詢－删除', :code=>'product_verifies/del'   , :state =>'Y')

Access.create!(:title => '入庫－首頁', :code=>'product_in_outs/index' , :state =>'Y')
Access.create!(:title => '入庫－新增', :code=>'product_in_outs/new'   , :state =>'Y')
Access.create!(:title => '入庫－編輯', :code=>'product_in_outs/edit'  , :state =>'Y')
Access.create!(:title => '入庫－删除', :code=>'product_in_outs/del'   , :state =>'Y')


Access.create!(:title => '入庫列表', :code=>'in_list'   , :state =>'Y')
Access.create!(:title => '入庫', :code=>'product_in_outs/new?type=in'   , :state =>'Y')

Access.create!(:title => '出貨列表', :code=>'out_list'   , :state =>'Y')
Access.create!(:title => '出貨', :code=>'product_in_outs/new?type=out'   , :state =>'Y')


Access.create!(:title => '銷售額查詢', :code=>'sale_list'      , :state =>'Y')
Access.create!(:title => '待出貨明細', :code=>'wat_orders'     , :state =>'Y')
Access.create!(:title => '對帳單查詢', :code=>'sale_compare'   , :state =>'Y')

Access.create!(:title => '日報', :code=>'dailies'   , :state =>'Y')
Access.create!(:title => '新增日報', :code=>'dailies/new'   , :state =>'Y')
Access.create!(:title => '排班/日報', :code=>'daily_18'   , :state =>'Y')

Access.create!(:title => '聯絡我們', :code=>'contactus'   , :state =>'Y')

Access.create!(:title => 'all', :code=>'all'   , :state =>'Y')

# 銷售額查詢 sale list
# 對帳單查詢 sale_compare
# 日報 Daily
# 排班/日報 Daily 18
# 聯絡我們 contact us


ProductVerifyType.create!(:name=>'食品-台灣官方',:verify_type_main_id=>1 , :state=>'Y')
ProductVerifyType.create!(:name=>'食品-大陸官方',:verify_type_main_id=>1 , :state=>'Y')
ProductVerifyType.create!(:name=>'食品-國際',:verify_type_main_id=>1 , :state=>'Y')

ProductVerifyType.create!(:name=>'化裝品-台灣官方',:verify_type_main_id=>2 , :state=>'Y')
ProductVerifyType.create!(:name=>'化裝品-大陸官方',:verify_type_main_id=>2 , :state=>'Y')

StoreArea.create!(:area_id =>'qw' , :area_name=>'test', :state => 'Y')

Trade.create!(:id =>'at' , :description=>'test', :state => 'Y')

InOutType.create!(:title =>'入庫' , :cate =>'add', :state => 'Y')
InOutType.create!(:title =>'出貨' , :cate =>'reduce', :state => 'Y')

Role.create!(:title => 'admin' , :text =>'all' , :code=>'all' , :state => 'Y')

Product.create!(:title=>'關節師傅',:specification => 'qwe2qwe2' , :user_id=>1 , :state=>'Y' , :verify_type_main_id =>1 , :code=>'12we')
Product.create!(:title=>'達利咖啡',:specification => 'coffe2w21q' , :user_id=>1 , :state=>'Y' , :verify_type_main_id =>1 , :code=>'e1232')

ProductVerifyState.create!(:id=>1 ,:title=>'申請中', :state=>'Y')
ProductVerifyState.create!(:id=>2 ,:title=>'申請成功', :state=>'Y')

PayType.create!(:code=>'card' ,:content=>'信用卡', :state=>'Y')
PayType.create!(:code=>'pay' ,:content=>'現金', :state=>'Y')

Member.create!(:name=>'boy', :tel =>'091234567', :address=>'1' ,  :state =>'Y')
Member.create!(:name=>'girl', :tel =>'091234567', :address=>'2', :state =>'Y')
Member.create!(:name=>'gg', :tel =>'091234567', :address=>'3', :state =>'Y')
Member.create!(:name=>'victor', :tel =>'091234567', :address=>'4', :state =>'Y')
