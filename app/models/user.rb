class User < ActiveRecord::Base
  #has_one :trade
  #分頁 每一頁5筆
  paginates_per 10

  scope :live, lambda { where("users.state = 'y' ") }

  validates :username,  :presence => { :message => "帳號－不能空白" } ,
                        :uniqueness => { :message => "帳號－有重複,請重新輸入" }

  validates :email,     :presence => { :message => "不能空白" } ,
                        :uniqueness => { :message => "有重複,請重新輸入" }
  # validates :password,        :presence => { :message => "密碼－不能空白" }
  # validates :re_password,     :presence => { :message => "重複密碼－不能空白" }
  # validates :forget_pas,      :presence => { :message => "忘記密碼－不能空白" }

  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i ,:message => "email－格式有誤！請重新輸入！"

  # column
  # :email, :company_address,:role_id,
  # :name,  :boss, :serial_code , :tel,
  # :send_address,  :check_date, :password,
  # :re_password, :forget_password, :text,
  # :trade_id, :store_area_id , :username)

end
