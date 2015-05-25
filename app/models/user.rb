class User < ActiveRecord::Base
  #has_one :trade
  #分頁 每一頁5筆
  paginates_per 10

  scope :live, lambda { where("users.state = 'y' ") }

  validates :username,  :presence => { :message => "帳號－不能空白" } ,
                        :uniqueness => { :message => "帳號－有重複,請重新輸入" },
                        :length => {:minimum => 5, :maximum => 254,:message => "帳號-要6到8個字元"}

  validates :name,  :presence => { :message => "姓名－不能空白" }

  validates_numericality_of :role_id, :only_integer => true ,:message => "角色只能輸入數字" # 必須是整數
  validates :role_id,  :presence => { :message => "角色－不能空白" },
            :length => {:minimum => 1, :maximum => 8,:message => "帳號-要6到8個字元"}


  validates :email,     :presence => { :message => "不能空白" } ,
                        :uniqueness => { :message => "有重複,請重新輸入" }

  validates :password,        :presence => { :message => "密碼－不能空白" }
  validates :re_password,     :presence => { :message => "重複密碼－不能空白" }
  # validates :forget_pas,      :presence => { :message => "忘記密碼提示－不能空白" }

  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i ,:message => "email－格式有誤！請重新輸入！"
  validates_format_of :username, :with => /\A([a-z0-9]+)/i ,:message => "帳號－格式有誤請重新輸入！"

  # column
  # :email, :company_address,:role_id,
  # :name,  :boss, :serial_code , :tel,
  # :send_address,  :check_date, :password,
  # :re_password, :forget_password, :text,
  # :trade_id, :store_area_id , :username)

end
