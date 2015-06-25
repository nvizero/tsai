class User < ActiveRecord::Base
  #has_one :trade
  #分頁 每一頁5筆
  paginates_per 10

  has_many :products



  scope :live, lambda { where("users.state = 'y' ") }
  scope :stoped  , lambda { where("users.state = 'N' ") }
  # scope :gg345  , lambda { where("users.id != '1' and users.id != '2' and users.id != '3'") }
  scope :vip_access, lambda {|query , session |
      if session[:vip_access]=='VIP'
          where(:id => query )
      elsif  session[:vip_access]=='admin'
          false
      elsif  session[:vip_access]=='normal'
          where(:id => session[:user_id] )
      end
  }

  # scope :search, lambda {|query|
  #   where(["`users`.`id` not in (?)", "%#{query}%"])
  # }
  validates :prompt,     :presence => { :message => "密碼提示不能空白" }
  validates :username,  :presence => { :message => "帳號－不能空白" } ,
                        :uniqueness => { :message => "帳號－有重複,請重新輸入" },
                        :length => {:minimum => 5, :maximum => 8,:message => "帳號-要6到8個字元"}

  validates :name,  :presence => { :message => "姓名－不能空白" }

  validates_numericality_of :role_id, :only_integer => true ,:message => "角色只能輸入數字" # 必須是整數
  validates :role_id,  :presence => { :message => "角色－不能空白" },
            :length => {:minimum => 1, :maximum => 8,:message => "帳號-要6到8個字元"}

  # validates :email,     :presence => { :message => "不能空白" } ,
  #                       :uniqueness => { :message => "有重複,請重新輸入" }



  validates :password,        :presence => { :message => "密碼－不能空白" } , :on => :create
  validates :re_password,     :presence => { :message => "重複密碼－不能空白" } , :on => :create




  attr_accessor :re_password

  before_create do
    self.state = "Y"
  end

end
