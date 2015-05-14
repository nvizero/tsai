class User < ActiveRecord::Base
  #has_one :trade
  belongs_to :trade
  scope :live, lambda { where("users.state = 'y' ") }
end
