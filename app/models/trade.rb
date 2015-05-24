class Trade < ActiveRecord::Base

  # belongs_to :user
  
  paginates_per 5
  # validates_length_of :id, :within => 1..2
  #validates_length_of :password, :in => 6..20 # 介於 6~20
  validates_presence_of :id
  validates_length_of   :id, :is => 2 # 剛好 6

  scope :sorted, lambda { order("trades.id ASC") }
end
