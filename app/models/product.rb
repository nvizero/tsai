class Product < ActiveRecord::Base

  paginates_per 10
  belongs_to :user
  belongs_to :verify_type_main
  has_many :product_in_outs

  has_many   :product_verifies

  scope :live , lambda { where("products.state = 'Y' ") }
  scope :stoped  , lambda { where("products.state = 'N' ") }

  scope :sandy  , lambda { where("products.user_id != '1' and products.user_id != '2' and products.user_id != '3'") }

  scope :vip_access, lambda { | query , session |
      if session[:vip_access] == 'VIP'
          where(:user_id => query )
      elsif  session[:vip_access] == 'admin'
          false
      elsif  session[:vip_access] == 'normal'
          where(:user_id => session[:user_id] )
      end
  }

  validates :title,         :presence => { :message => "產品名稱－不能空白" }
  validates :code,          :presence => { :message => "料品編號－不能空白" } ,
                            :length => {:minimum => 1, :maximum => 8, :message => "庫位代碼－最多輸入8碼" } ,
                            :uniqueness => { :message => "料品編號－是唯一值,請重新輸入" }

  validates :user_id,       :presence => { :message => "使用者－不能空白" }
  validates :specification,       :presence => { :message => "規格－不能空白" },
                                  :length => {:minimum => 1, :maximum => 20, :message => "規格－最多輸入20碼" }
  # is_finish
  before_create do
    self.state = "Y"
  end
  # (:title, :content, :num, :user_id)

end
