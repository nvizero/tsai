class ProductOrder < ActiveRecord::Base

  paginates_per 10

  belongs_to :member
  belongs_to :order_state

  scope :stoped  , lambda { where("product_orders.state = 'N' ") }
  scope :live, lambda { where("product_orders.state = 'Y' ") }

  validates :member_id,        :presence => { :message => "訂購者－不能為空" }
  validates :code,  :presence => { :message => "帳號－不能空白" } ,
                        :uniqueness => { :message => "帳號－有重複,請重新輸入" }


  scope :vip_access, lambda {|query , session |
      if session[:vip_access]=='VIP'
          where(:create_user_id => query )
      elsif  session[:vip_access]=='admin'
          false
      elsif  session[:vip_access]=='normal'
          where(:create_user_id => session[:user_id] )
      end
  }

  before_create do
    self.state = "Y"
  end
end
