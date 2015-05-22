class User < ActiveRecord::Base
  #has_one :trade
  #分頁 每一頁5筆
  paginates_per 5
  has_many :pages
  #belongs_to :trade
  scope :live, lambda { where("users.state = 'y' ") }
  
end
