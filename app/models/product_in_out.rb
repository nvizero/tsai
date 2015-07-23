class ProductInOut < ActiveRecord::Base
  paginates_per 10
  belongs_to :product
  belongs_to :in_out_type
  belongs_to :store_area

  # scope :sorted  , lambda { order("product_in_outs.id desc ") }
  scope :sorted, lambda { order("product_in_outs.updated_at desc") }
  scope :in_come  , lambda { where("product_in_outs.in_or_out = 'add' ") }
  scope :out_come  , lambda { where("product_in_outs.in_or_out = 'reduce' ") }

  scope :live  , lambda { where("product_in_outs.state = 'Y' ") }
  scope :stoped  , lambda { where("product_in_outs.state = 'N' ") }

  # scope :GroupByLevle  , lambda { group("product_in_outs.level ") }

  validates :level,             :presence => { :message => "等級不能空白" }

  validates :product_id,        :presence => { :message => "產品名稱不能空白" }
  validates :in_out_type_id,       :presence => { :message => "入庫/出庫分類不能空白" }
  validates_inclusion_of :num, :in => 1..9999999 ,:message => "產品數量－為正整數"
  validates :num,       :presence => { :message => "產品數量－不能空白" }
  validates :serial, :presence => { :message => "批號不能空白" }

  # .group(:serial)
  # .group(:save_date)
  # .group(:in_or_out)
  # .group(:store_area_id)
  # .group(:level)

  scope :gby, lambda {
      self
      .group(:serial)
      .group(:save_date)
      .group(:in_or_out)
      .group(:store_area_id)
      .group(:level)
  }

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
