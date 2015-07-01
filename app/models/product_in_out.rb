class ProductInOut < ActiveRecord::Base
  paginates_per 10
  belongs_to :product
  belongs_to :in_out_type
  belongs_to :store_area
  scope :in_come  , lambda { where("product_in_outs.in_or_out = 'add' ") }
  scope :out_come  , lambda { where("product_in_outs.in_or_out = 'reduce' ") }

  scope :live  , lambda { where("product_in_outs.state = 'Y' ") }
  scope :stoped  , lambda { where("product_in_outs.state = 'N' ") }



  # validates :num,       :presence => { :message => "產品數量－不能空白" ,
  # :only_integer => true,
  # :length => :minimum => 1 }



  validates :in_out_type_id,       :presence => { :message => "入庫/出庫分類不能空白" }
  validates_inclusion_of :num, :in => 1..9999999 ,:message => "產品數量－不能空白"
  validates :num,       :presence => { :message => "產品數量－不能空白" }


  scope :vip_access, lambda {|query , session |
      if session[:vip_access]=='VIP'
          where(:create_user_id => query )
      elsif  session[:vip_access]=='admin'
          false
      elsif  session[:vip_access]=='normal'
          where(:create_user_id => session[:user_id] )
      end
  }




end
