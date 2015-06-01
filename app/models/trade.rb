class Trade < ActiveRecord::Base

  # belongs_to :user

  paginates_per 5
  # validates_length_of :id, :within => 1..2
  #validates_length_of :password, :in => 6..20 # 介於 6~20
  # validates_presence_of :id ,  :presence => { :message => "不能空白" } ,
  # validates_length_of   :id, :is => 2 # 剛好 6

  # validates_length_of :name, :minimum => 2 # 最少 2
  # validates_length_of :bio, :maximum => 500 # 最多 500
  # validates_length_of :password, :in => 6..20 # 介於 6~20
  # validates_length_of :registration_number, :is => 6 # 剛好 6

  scope :sorted, lambda { order("trades.id ASC") }
  scope :live, lambda { where("trades.state = 'Y' ") }


  validates :id,  :presence => { :message => "交易代碼－不能空白" } ,
                  :length => {:minimum => 1, :maximum => 2, :message => "交易代碼－只能輸入2碼" } ,
                  :uniqueness => { :message => "交易代碼－是唯一值－有重複,請重新輸入" }


  validates :description,  :presence => { :message => "說明－不能空白" }
  before_create do
    self.state = "Y"
  end

  # validate :my_validation
  #
  # private
  #
  #   def my_validation
  #       if id =~ /cc/
  #           errors[:id] << "can not be cc ->> "+id
  #       elsif name =~ /bar/
  #           errors[:name] << "can not be bar"
  #       elsif name == 'xxx'
  #           errors[:base] << "can not be xxx"
  #     	end
  #   end
end
