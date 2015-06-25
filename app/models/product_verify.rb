class ProductVerify < ActiveRecord::Base

  paginates_per 12
  belongs_to   :product
  belongs_to   :product_verify_type
  belongs_to   :product_verify_state

  has_many   :product_verify_contents
  # def products
  #
  # end

  scope :vip_access, lambda {|query , session |
      if session[:vip_access]=='VIP'
          where(:create_user_id => query )
      elsif  session[:vip_access]=='admin'
          false
      elsif  session[:vip_access]=='normal'
          where(:create_user_id => session[:user_id] )
      end
  }

  scope :stoped  , lambda { where("product_verifies.state = 'N' ") }
  scope :live, lambda { where("product_verifies.state = 'Y' ") }
  before_create do
    self.state = "Y"
  end
end
