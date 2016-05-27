class Member < ActiveRecord::Base

  paginates_per 10


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  scope :stoped  , lambda { where("members.state = 'N' ") }
  scope :live, lambda { where("members.state = 'Y' ") }

  # validates :name,      :presence => { :message => "性名－不能空白" }
  # validates :tel,       :presence => { :message => "電話－不能空白" }
  # validates :address,   :presence => { :message => "住址－不能空白" }

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
